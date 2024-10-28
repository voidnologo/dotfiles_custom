# alias git="hub"
# alias webopen="python -c \"import webbrowser; webbrowser.open('$1')\""
alias calendar='python -c "import calendar; import sys; from datetime import date; print(calendar.calendar(int(sys.argv[1]) if len(sys.argv) > 1 else date.today().year))" $1'
alias check-yapf='yapf . --recursive --diff --exclude="./jenkins-*" --style="{based_on_style: facebook, COLUMN_LIMIT: 120, BLANK_LINE_BEFORE_NESTED_CLASS_OR_DEF: true}" | grep "^+++" > reports/yapf.txt'
alias define="PYTHONPATH=$HOME/.pyenv/versions/dictionary/lib/python3.9/site-packages $HOME/.pyenv/versions/dictionary/bin/python $HOME/.pyenv/versions/dictionary/dict.py"
alias define="PYTHONPATH=$HOME/.virtualenvs/dictionary/lib/python3.6/site-packages $HOME/.virtualenvs/dictionary/bin/python $HOME/.virtualenvs/dictionary/bin/dict.py"
alias git-track='function _gittrack(){ git branch --set-upstream-to=origin/"$1" "$1";};_gittrack'
alias ip='curl ifconfig.co/'
alias itsuka='now; utc'
alias killhidden="defaults write com.apple.finder AppleShowAllFiles FALSE;killall Finder"
alias now='date +%a%t%m/%d/%Y%t%H:%M:%S\ %z\(%Z\)'
alias pyclean="find . -name '*.pyc' -delete"
alias refresh='git pull origin staging; cd fitspot; python manage_db.py db upgrade; cd ..'
alias run-phx='iex -S mix phx.server'
alias runtests='nosetests tests --nologcapture'
alias sag='sudo apt-get'
alias sagi='sudo apt-get install'
alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE;killall Finder"
alias showstash="git stash list | awk -F: '{ print \"\n\n\n\n\"; print $0; print \"\n\n\"; system(\"git stash show -p \" $1); }'"
alias start-redis="sudo redis-server /usr/local/etc/redis.conf"
alias tree="tree -I '*.pyc|__pycache__'"
alias utc='date -u +%a%t%m/%d/%Y%t%H:%M:%S\ %z\(%Z\)'
alias uuid4='python -c "import uuid; print(uuid.uuid4(), end=\"\")" | pbcopy'
alias weather='curl wttr.in/37421'
alias webopen="python -c \"import webbrowser; webbrowser.open('$1')\""
alias when='now; utc'
alias which-tmux='tmux display-message -p "#S"'

alias telegraph-staging-flower="docker run -p 5555:5555 -e CELERY_BROKER_URL=redis://tg-staging-redis.xjsvsc.0001.use2.cache.amazonaws.com:6379 mher/flower:latest"
