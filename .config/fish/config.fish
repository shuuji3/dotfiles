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

# scalaenv
status --is-interactive; and source (scalaenv init -|psub)

# parl
set -l perl_path /usr/local/Cellar/perl/5.24.0_1/bin/
if [ -d $perl_path ]
  set -x PATH $perl_path $PATH
end

# go
set -g fish_user_paths $fish_user_paths /usr/local/opt/go/libexec/bin

# google-cloud-sdk
set -x PATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin $PATH
set -x MANPATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/help/man /usr/local/share/man /usr/share/man /opt/x11/share/man

# hub
function git --description 'Alias for hub, which wraps git to provide extra functionality with GitHub.'
    hub $argv
end
