if test -d ~/.arkade/bin/
    set -gx PATH $PATH $HOME/.arkade/bin/
end

if which arkade > /dev/null
    alias ark=arkade
end
