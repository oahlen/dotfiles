function colors --description "Print available terminal colors"
    set T gYw

    echo -e ""
    printf "       │  def     40m     41m     42m     43m     44m     45m     46m     47m  \n"
    printf " ──────┼───────────────────────────────────────────────────────────────────────\n"

    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
        '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
        '  36m' '1;36m' '  37m' '1;37m'

        set FG (string trim $FGs)
        printf " $FGs │\033[$FG  $T  "

        for BG in 40m 41m 42m 43m 44m 45m 46m 47m
            printf "$EINS \033[$FG\033[$BG  $T  \033[0m"
        end
        echo
    end
    echo
end
