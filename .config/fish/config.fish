# set path
if [ -d $HOME/bin ]
    set -g fish_user_paths $HOME/bin $fish_user_paths
end
for path in $HOME/.local/bin 
    if [ -d $path ]
        set -g PATH $path $PATH
    end
end

# python
status --is-interactive; and source (pyenv init -|psub)
set -x PYTHONPATH $HOME/src $PYTHONPATH

# rbenv
status --is-interactive; and source (rbenv init -|psub)

# scalaenv
#status --is-interactive; and source (scalaenv init -|psub)

# parl
set -l perl_path /usr/local/Cellar/perl/5.24.0_1/bin/
if [ -d $perl_path ]
  set -x PATH $perl_path $PATH
end

# go
#set -g fish_user_paths $fish_user_paths /usr/local/opt/go/libexec/bin
set -x GOPATH $HOME/go

# google-cloud-sdk
set -x PATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin $PATH
set -x MANPATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/help/man /usr/local/share/man /usr/share/man /opt/x11/share/man

# hub
function git --description 'Alias for hub, which wraps git to provide extra functionality with GitHub.'
    hub $argv
end

# OPAM configuration for OCaml
. $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true

# android
set -x ANDROID_HOME $HOME/Library/Android/sdk/
set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)

# nvm: node version manager
set -x NVM_DIR $HOME/.nvm
source ~/.config/fish/nvm-wrapper/nvm.fish

