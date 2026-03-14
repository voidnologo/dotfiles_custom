# Claude Code — Context Monitor & Statusline

Two global Claude Code hooks that show context usage in the status bar and warn you (and Claude) when context is running low.

## What it does

**Statusline** (`statusline.js`): Renders a persistent bar at the bottom of every Claude Code session showing:
```
claude-sonnet-4-6 │ home ████████░░ 83%
```
The percentage is inflated by +5% vs. reality — so if the context window is truly 70% full, it shows 75%. This is intentional: it nudges you to wrap up while there's still real headroom.

Color progression (based on inflated value):
- Green: < 60%
- Yellow: 60–74%
- Orange: 75–84%
- Blinking red: 85%+

If a Claude task is in progress (via the TodoWrite tool), the current task name appears in the bar.

**Context monitor** (`context-monitor.js`): A `PostToolUse` hook that injects warnings into Claude's context when usage is high. Claude sees these warnings and will proactively tell you — and offer to write a `continuation_prompt` file so you can resume in a fresh session.

Thresholds (based on raw remaining, before inflation):
- **WARNING** (≤20% raw remaining → ~85% shown): Claude suggests wrapping up and offers a continuation_prompt
- **CRITICAL** (≤10% raw remaining → ~95% shown): Claude stops new work and asks to save state

Warnings are debounced (fires once, then silences for 5 tool uses) to avoid spam. Severity escalation (WARNING → CRITICAL) bypasses the debounce.

## How it works internally

The statusline runs on every render and writes a small JSON bridge file to `/tmp/claude-ctx-{session_id}.json` containing the raw and inflated usage values. The context-monitor hook reads that file after each tool use to decide whether to inject a warning. They share no other state.

## Setup

### 1. Copy the scripts

```bash
mkdir -p ~/.claude/hooks
cp statusline.js ~/.claude/hooks/statusline.js
cp context-monitor.js ~/.claude/hooks/context-monitor.js
chmod +x ~/.claude/hooks/statusline.js ~/.claude/hooks/context-monitor.js
```

### 2. Edit `~/.claude/settings.json`

Add the following keys (merge with any existing content):

```json
{
  "statusLine": {
    "type": "command",
    "command": "node /home/YOUR_USERNAME/.claude/hooks/statusline.js"
  },
  "hooks": {
    "PostToolUse": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "node /home/YOUR_USERNAME/.claude/hooks/context-monitor.js"
          }
        ]
      }
    ]
  }
}
```

Replace `YOUR_USERNAME` with your actual username. Absolute paths are required here — `~` is not expanded by Claude Code.

### 3. Restart Claude Code

The statusline and hooks take effect on the next session start.

## Requirements

- Node.js (any recent version — only uses `fs`, `path`, `os`, `process`)
- Claude Code CLI

## Notes

- These are **global** settings (`~/.claude/settings.json`) and apply to all sessions. Project-level `settings.json` files can override them.
- If you also use GSD, the prophets project (or any project with GSD's own context-monitor) will run both monitors. They don't conflict — they just both warn, which is fine.
- The +5% inflation and 85% warning threshold are tunable at the top of each script.
