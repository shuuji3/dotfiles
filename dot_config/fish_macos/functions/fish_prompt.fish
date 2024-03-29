function fish_prompt --description 'Write out the prompt'
    # Just calculate this once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    set -l color_cwd
    set -l suffix
    switch $USER
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '>'
    end

    # Set __fish_git_prompt options
    set -g __fish_git_prompt_show_informative_status true
    
    echo -s (set_color purple) (env LANG=C date "+%Y-%m-%d(%a) %H:%M:%S") ' ' (set_color blue) "$USER" @ "$__fish_prompt_hostname" ' ' (set_color $color_cwd) (prompt_pwd) (set_color yellow) (__fish_git_prompt) "$__fish_git_prompt_dirty" (set_color normal)
    echo -n "$suffix "
end
