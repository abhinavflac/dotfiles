# Old Hyprdots-based prompt loader
# This file is used to load the old oh-my-posh prompt style.

if command -v oh-my-posh >/dev/null 2>&1 && [[ -f "$HOME/.poshthemes/1_shell.omp.json" ]]; then
    eval "$(oh-my-posh init zsh --config $HOME/.poshthemes/1_shell.omp.json)"
elif command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
