#
# Rudimentary Bash completion definition for nnn.
#
# Author:
#   Arun Prakash Jana <engineerarun@gmail.com>
#

_nnn ()
{
    COMPREPLY=()
    local IFS=$'\n'
    local cur=$2 prev=$3
    local -a opts
    opts=(
        -a
        -A
        -b
        -c
        -d
        -e
        -E
        -g
        -H
        -K
        -n
        -o
        -p
        -Q
        -r
        -R
        -s
        -S
        -t
        -T
        -V
        -x
        -h
    )
    if [[ $prev == -b ]]; then
        local bookmarks=$(echo $NNN_BMS | awk -F: -v RS=\; '{print $1}')
        COMPREPLY=( $(compgen -W "$bookmarks" -- "$cur") )
    elif [[ $prev == -p ]]; then
        COMPREPLY=( $(compgen -f -d -- "$cur") )
    elif [[ $prev == -s ]]; then
        local sessions_dir=${XDG_CONFIG_HOME:-$HOME/.config}/nnn/sessions
        COMPREPLY=( $(cd "$sessions_dir" && compgen -f -d -- "$cur") )
    elif [[ $prev == -t ]]; then
        return 1
    elif [[ $prev == -T ]]; then
        local keys=$(echo "a d e r s t v" | awk -v RS=' ' '{print $0}')
        COMPREPLY=( $(compgen -W "$keys" -- "$cur") )
    elif [[ $cur == -* ]]; then
        COMPREPLY=( $(compgen -W "${opts[*]}" -- "$cur") )
    else
        COMPREPLY=( $(compgen -f -d -- "$cur") )
    fi
}

complete -o filenames -F _nnn nnn
