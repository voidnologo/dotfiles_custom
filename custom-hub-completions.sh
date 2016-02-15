# hub completions
fpath=(~/dotfiles/custom-configs/zsh/completions $fpath)
compinit
compdef _hub git
