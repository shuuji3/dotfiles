# set path
set -g fish_user_paths $HOME/bin $fish_user_paths
set -g PATH $HOME/.local/bin /usr/local/bin $PATH

# pyenv
status --is-interactive; and source (pyenv init -|psub)

# rbenv
status --is-interactive; and source (rbenv init -|psub)

# go
set -g fish_user_paths $fish_user_paths /usr/local/opt/go/libexec/bin
