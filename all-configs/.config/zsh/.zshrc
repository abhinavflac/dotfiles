#####################################
##==> Aliases
#####################################
alias cls="clear"
alias g="git"
alias n="nvim"
alias m="micro"
alias ls="lsd"
alias tree="lsd --tree"
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
setopt autocd

#####################################
##==> binds
#####################################
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

#####################################
##==> Custom Functions
#####################################
function wget() {
    command wget --hsts-file="${XDG_DATA_HOME}/wget-hsts" "$@"
}

function nvidia-settings() {
    mkdir -p "${XDG_CONFIG_HOME}/nvidia/"
    command nvidia-settings --config="${XDG_CONFIG_HOME}/nvidia/settings" "$@"
}

function cd() {
    if [[ $@ == "...*" ]]; then
        builtin cd "${@//../..}"
    else
        builtin cd "$@"
    fi
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

#####################################
##==> Shell Customization
#####################################
if [[ -f "$HOME/.config/zsh/prompt.zsh" ]]; then
    source "$HOME/.config/zsh/prompt.zsh"
fi

if command -v pokemon-colorscripts >/dev/null 2>&1 && command -v fastfetch >/dev/null 2>&1; then
    pokemon-colorscripts --no-title -s -r 1,3,6 | fastfetch --file-raw -
elif command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi

#####################################
##==> Plugins
#####################################
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# [[ -f "$HOME/.config/zsh/themes/meowrch.zsh" ]] && \
#     source "$HOME/.config/zsh/themes/meowrch.zsh"

# PAW-THEME-POST-START: catppuccin-mocha
# source $HOME/.config/zsh/themes/pawlette-catppuccin-mocha.zsh
# PAW-THEME-POST-END: catppuccin-mocha

if [[ -f "$HOME/.config/zsh/prompt.zsh" ]]; then
    source "$HOME/.config/zsh/prompt.zsh"
fi
# Portable Conda Initialization
# Dynamically source conda if it exists without hardcoding paths.
for conda_path in "/opt/miniconda3" "$HOME/miniconda3" "$HOME/hyprmod/ls"; do
    if [ -f "${conda_path}/etc/profile.d/conda.sh" ]; then
        . "${conda_path}/etc/profile.d/conda.sh"
        break
    fi
done

