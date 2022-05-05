set android_path $HOME/Library/Android/sdk/platform-tools/
if test -d $android_path
    set -gx PATH $android_path $PATH
end
