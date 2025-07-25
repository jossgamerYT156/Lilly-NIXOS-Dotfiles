#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export PATH=/nix/System/Sys:$PATH

mkdir -p /nix/System/GIT
_git() {
    if [[ "$1" == "clone" && "$#" -eq 2 ]]; then
        command git clone "$2" "/nix/System/GIT/$(basename "$2" .git)"
    else
        command git "$@"
    fi
}
alias git=_git

sys() {
    case "$1" in
        -h|--help)
            echo "
    J-NIX (NIX OS with J Customization)

            Built-In Directives:
            --os <subdirective>
            
Subdirectives >>    info|shreload
            
            --pkg <subdirective> <optional_argument>

Subdirectives >>    install|remove|list|info

            -h|--help
            <Shows This Menu>
>> No Subdirectives Available(Yet)

    J-NIX - Customization By: Lilly Aizawa
            "
        ;;
        --os)
            shift
            case "$1" in
                i|info)
                    shift
                    neofetch
                    ;;
                shr|shreload)
                    source $HOME/.bashrc
                    echo "Reloaded SHELL Profile"
                    ;;
                *)
                    echo "No Such Directive For: SYS"
                    ;;
            esac
            ;;
        --pkg)
            shift
            case "$1" in
                i|install)
                    shift
                    pm_i "$1"
                    ;;
                rm|remove)
                    shift
                    nix-env -e "$1"
                    rm -f /nix/System/Sys/"$1"
                    ;;
                l|list)
                    ls /nix/System/Sys
                    ;;
                inf|info)
                    shift
                    nix-env -qaP | grep "$1"
                    ;;
                *)
                    echo "No Such Directive For: PKG
                    Directive Used:[$1]
                    Directive Expected:
                    --info|list|remove|install"
                    ;;
            esac
            ;;
        --git)
            shift
            git "$@"
            ;;
        *)
            echo "Unknown sys command: $1"
            ;;
    esac
}

nix-install() {
    nix-env -iA nixpkgs.$1 && ln -sf ~/.nix-profile/bin/$1 /nix/System/Sys/$1
}

alias pm_i=nix-install
alias sys=sys

alias clt=clear
alias CLT=clear
