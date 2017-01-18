# set path
if [ -d $HOME/bin ]
    set -g fish_user_paths $HOME/bin $fish_user_paths
end
for path in $HOME/.local/bin /usr/local/bin
    if [ -d $path ]
        set -g PATH $path $PATH
    end
end

# pyenv
status --is-interactive; and source (pyenv init -|psub)

# rbenv
status --is-interactive; and source (rbenv init -|psub)

# go
set -g fish_user_paths $fish_user_paths /usr/local/opt/go/libexec/bin
