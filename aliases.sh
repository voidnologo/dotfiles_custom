alias calendar='python -c "import calendar; import sys; from datetime import date; print(calendar.calendar(int(sys.argv[1]) if len(sys.argv) > 1 else date.today().year))" $1'
alias git-track='function _gittrack(){ git branch --set-upstream-to=origin/"$1" "$1";};_gittrack'
alias ip='curl ifconfig.co/'
alias killhidden="defaults write com.apple.finder AppleShowAllFiles FALSE;killall Finder"
alias now='date +%a%t%m/%d/%Y%t%H:%M:%S\ %z\(%Z\)'
alias pyclean="find . -name '*.pyc' -delete"
alias run-phx='iex -S mix phx.server'
alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE;killall Finder"
alias showstash="git stash list | awk -F: '{ print \"\n\n\n\n\"; print $0; print \"\n\n\"; system(\"git stash show -p \" $1); }'"
alias tree="tree -I '*.pyc|__pycache__'"
alias utc='date -u +%a%t%m/%d/%Y%t%H:%M:%S\ %z\(%Z\)'
alias uuid4='python -c "import uuid; print(uuid.uuid4(), end=\"\")" | pbcopy'
# alias weather='curl wttr.in/37422'
alias weather='curl -s "v2.wttr.in/37421?format=%l:+%c+%t+(feels+like+%f)+%w"'
alias webopen="python -c \"import webbrowser; webbrowser.open('$1')\""
alias when='now; utc'
alias which-tmux='tmux display-message -p "#S"'
alias prep_test='./temp/start_test_env'

alias telegraph-staging-flower="docker run -p 5555:5555 -e CELERY_BROKER_URL=redis://tg-staging-redis.xjsvsc.0001.use2.cache.amazonaws.com:6379 mher/flower:latest"
alias refresh='docker compose -f tests/docker-compose.yml down -v && docker compose -f tests/docker-compose.yml up -d'
alias run_test='pytest tests --ignore tests/util/stedi/test_adapter.py --disable-warnings'
alias uv-sync='uv sync --active'

# Editor
# Default to neovim so the habit sticks; `vi` is the escape hatch to real vim.
# `command` is required - a bare `vim` here re-expands through the alias above.
alias vim='nvim'
alias vi='command vim'

# PostgreSQL
alias psql-start='sudo systemctl start postgresql'
alias psql-stop='sudo systemctl stop postgresql'

# Audio
alias headphone-check='amixer -c 2 sget Headphone'
alias headphone-fix='amixer -c 2 sset Headphone 100% on'

# Sleep inhibitor
alias nosleep-on='source ~/dotfiles/custom-configs/dotfiles_custom/nosleep.sh on'
alias nosleep-off='source ~/dotfiles/custom-configs/dotfiles_custom/nosleep.sh off'
alias nosleep-status='source ~/dotfiles/custom-configs/dotfiles_custom/nosleep.sh status'

# Nvidia
alias watch='watch -n 1 nvidia-smi'

# bikiri-linux is hybrid AMD iGPU (default renderer) + NVIDIA dGPU - the external
# monitor port is wired directly to the dGPU for output, but rendering still
# defaults to the iGPU. Force dGPU rendering for anything launched this way.
alias steam='env __NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia steam'

# KDE Plasma
alias restart-kde='kwin_wayland --replace & disown && plasmashell --replace & disown'

# Docker
alias docker-start='sudo systemctl start docker'
alias docker-stop='sudo systemctl stop docker docker.socket'

alias open='xdg-open'
