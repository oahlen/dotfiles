function fish_prompt --description "Write out the prompt"
    set -lx fish_prompt_pwd_dir_length 1
    set -lx fish_prompt_pwd_full_dirs 3

    # Capture status variable since it will be replaced further down
    set -l last_status $status
    set -l status_prompt
    if test $last_status -ne 0
        set status_prompt (set_color $fish_color_status)" [$last_status]"(set_color normal)
    end

    set -l shell_prompt
    if test $NIX_SHELL
        set shell_prompt (set_color normal)" with" (set_color $fish_color_special)" ($NIX_SHELL)"
    end

    echo -s (set_color $fish_color_cwd)(prompt_pwd) (set_color normal)" on"(fish_vcs_prompt) $shell_prompt $status_prompt
    echo -n -s (set_color $fish_color_prefix)"> "
end
