alias sag='sudo apt-get'
alias sagi='sudo apt-get install'
alias tree="tree -I '*.pyc|__pycache__'"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE;killall Finder"
alias killhidden="defaults write com.apple.finder AppleShowAllFiles FALSE;killall Finder"
alias pyclean="find . -name '*.pyc' -delete"
alias start-redis="sudo redis-server /usr/local/etc/redis.conf"
alias showstash="git stash list | awk -F: '{ print \"\n\n\n\n\"; print $0; print \"\n\n\"; system(\"git stash show -p \" $1); }'"
# alias git="hub"
alias git-track='function _gittrack(){ git branch --set-upstream-to=origin/"$1" "$1";};_gittrack'
alias which-tmux='tmux display-message -p "#S"'
# alias webopen="python -c \"import webbrowser; webbrowser.open('$1')\""
alias define="PYTHONPATH=$HOME/.pyenv/versions/dictionary/lib/python3.9/site-packages $HOME/.pyenv/versions/dictionary/bin/python $HOME/.pyenv/versions/dictionary/dict.py"
alias check-yapf='yapf . --recursive --diff --exclude="./jenkins-*" --style="{based_on_style: facebook, COLUMN_LIMIT: 120, BLANK_LINE_BEFORE_NESTED_CLASS_OR_DEF: true}" | grep "^+++" > reports/yapf.txt'
alias now='date +%a%t%m/%d/%Y%t%H:%M:%S\ %z\(%Z\)'
alias refresh='git pull origin staging; cd fitspot; python manage_db.py db upgrade; cd ..'
alias runtests='nosetests tests --nologcapture'
alias ip='curl ifconfig.co/'
