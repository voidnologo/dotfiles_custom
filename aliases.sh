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
