function fish_prompt --description "Write out the prompt"
    set -lx fish_prompt_pwd_dir_length 1
    set -lx fish_prompt_pwd_full_dirs 3

    echo -s (set_color $fish_color_cwd)(prompt_pwd) (set_color normal)" on"(fish_git_prompt)
    echo -n -s (set_color $fish_color_prefix)"> "
end
