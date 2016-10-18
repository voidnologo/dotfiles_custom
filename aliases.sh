alias p3m='python3 manage.py'
alias p3='python3'
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
alias ec2="AWS_DEFAULT_PROFILE=prod-eb-cli /Users/imtapps/.virtualenvs/aws-fuzzy/bin/aws-fuzzy --key-path ~/.ssh/staging-key-bastion.pem --tunnel --tunnel-key-path 'staging-key-beanstalk.pem'"
alias ec2-prod="AWS_DEFAULT_PROFILE=prod-eb-cli /Users/imtapps/.virtualenvs/aws-fuzzy/bin/aws-fuzzy --key-path ~/.ssh/production-key-bastion.pem --tunnel --tunnel-key-path 'production-key-beanstalk.pem'"
