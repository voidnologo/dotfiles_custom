#!/usr/bin/env node
// Context Monitor - PostToolUse hook
// Reads context metrics from the statusline bridge file and injects
// warnings when context is high. Makes the AGENT aware of limits.
//
// Thresholds (based on RAW remaining_percentage, since bridge stores raw):
//   WARNING  (remaining <= 20%): inflated shown value ~85% — begin wrapping up
//   CRITICAL (remaining <= 10%): inflated shown value ~95% — stop and save state
//
// Debounce: 5 tool uses between warnings to avoid spam
// Severity escalation (WARNING -> CRITICAL) bypasses debounce

const fs = require('fs');
const os = require('os');
const path = require('path');

const WARNING_THRESHOLD  = 20;  // raw remaining <= 20% → inflated shown ~85%
const CRITICAL_THRESHOLD = 10;  // raw remaining <= 10% → inflated shown ~95%
const STALE_SECONDS      = 60;
const DEBOUNCE_CALLS     = 5;

let input = '';
process.stdin.setEncoding('utf8');
process.stdin.on('data', chunk => input += chunk);
process.stdin.on('end', () => {
  try {
    const data = JSON.parse(input);
    const sessionId = data.session_id;
    if (!sessionId) process.exit(0);

    const metricsPath = path.join(os.tmpdir(), `claude-ctx-${sessionId}.json`);
    if (!fs.existsSync(metricsPath)) process.exit(0);

    const metrics = JSON.parse(fs.readFileSync(metricsPath, 'utf8'));
    const now = Math.floor(Date.now() / 1000);
    if (metrics.timestamp && (now - metrics.timestamp) > STALE_SECONDS) process.exit(0);

    const remaining = metrics.remaining_percentage;  // raw
    const usedPct   = metrics.used_pct;              // inflated (+5%)

    if (remaining > WARNING_THRESHOLD) process.exit(0);

    // Debounce
    const warnPath = path.join(os.tmpdir(), `claude-ctx-${sessionId}-warned.json`);
    let warnData = { callsSinceWarn: 0, lastLevel: null };
    let firstWarn = true;
    if (fs.existsSync(warnPath)) {
      try {
        warnData = JSON.parse(fs.readFileSync(warnPath, 'utf8'));
        firstWarn = false;
      } catch (e) {}
    }

    warnData.callsSinceWarn = (warnData.callsSinceWarn || 0) + 1;

    const isCritical = remaining <= CRITICAL_THRESHOLD;
    const currentLevel = isCritical ? 'critical' : 'warning';
    const severityEscalated = currentLevel === 'critical' && warnData.lastLevel === 'warning';

    if (!firstWarn && warnData.callsSinceWarn < DEBOUNCE_CALLS && !severityEscalated) {
      fs.writeFileSync(warnPath, JSON.stringify(warnData));
      process.exit(0);
    }

    warnData.callsSinceWarn = 0;
    warnData.lastLevel = currentLevel;
    fs.writeFileSync(warnPath, JSON.stringify(warnData));

    let message;
    if (isCritical) {
      message = `CONTEXT MONITOR CRITICAL: Context is ~${usedPct}% full (${Math.round(remaining)}% actually remaining). ` +
        'STOP new work immediately. Inform the user that context is nearly exhausted. ' +
        'Offer to write a continuation_prompt file summarizing current state, open decisions, and the next step, ' +
        'so the user can paste it into a fresh session and pick up without losing context.';
    } else {
      message = `CONTEXT MONITOR WARNING: Context is ~${usedPct}% full (${Math.round(remaining)}% actually remaining). ` +
        'Begin wrapping up the current task. Do not start new complex work. ' +
        'Suggest to the user that they consider starting a fresh session soon, and offer to write a ' +
        'continuation_prompt file that captures the current state so nothing is lost.';
    }

    process.stdout.write(JSON.stringify({
      hookSpecificOutput: {
        hookEventName: "PostToolUse",
        additionalContext: message
      }
    }));
  } catch (e) {
    process.exit(0);
  }
});
