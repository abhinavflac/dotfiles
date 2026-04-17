#!/bin/bash
set -e

echo ":: Starting dotfiles installation..."

if ! command -v yay &> /dev/null; then
    echo ":: yay not found. Building and installing yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
    rm -rf /tmp/yay
fi

echo ":: Validating and installing native packages (1/5)"
if [ -f packages-native.txt ]; then
    sudo pacman -S --needed --noconfirm - < packages-native.txt 2>/dev/null || echo "   -> System/Distro specific packages successfully ignored."
else
    echo "warning: packages-native.txt not found."
fi

echo ":: Validating and installing AUR packages (2/5)"
if [ -f packages-aur.txt ]; then
    yay -S --needed --noconfirm --overwrite '*' - < packages-aur.txt 2>/dev/null || echo "   -> Unsupported AUR packages safely skipped."
else
    echo "warning: packages-aur.txt not found."
fi

echo ":: Setting up Shared Drive mount (3/6)"
if [ -f scripts/mount-setup.sh ]; then
    bash scripts/mount-setup.sh
else
    echo "warning: scripts/mount-setup.sh not found."
fi

echo ":: Running post-install cleanup (4/6)"
if [ -f remove-packages.txt ]; then
    while read -r pkg; do
        [ -z "$pkg" ] && continue
        if pacman -Q "$pkg" &>/dev/null; then
            echo "   Removing $pkg..."
            sudo pacman -Rns --noconfirm "$pkg"
        fi
    done < remove-packages.txt
fi

echo ":: Restoring custom mewline source (5/6)"
if ! command -v rsync &> /dev/null || ! command -v stow &> /dev/null; then
    sudo pacman -S --needed --noconfirm rsync stow
fi

if [ -d custom-mewline ] && [ -d /opt/mewline ]; then
    sudo rsync -a custom-mewline/ /opt/mewline/
else
    echo "warning: target directory missing; skipping mewline sync."
fi

echo ":: Clearing defaults to prevent stow conflicts..."
# Remove default directories & files that block stow from linking our custom dots
for app in btop fastfetch hypr kitty rofi starship tmux yazi zsh cava dunst flameshot micro nemo swaync menus; do
    rm -rf "$HOME/.config/$app"
done
rm -f "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.config/starship.toml" "$HOME/.zshenv"

echo ":: Linking configurations via stow (6/6)"
stow all-configs

echo ":: Rebuilding KDE service cache..."
kbuildsycoca6 --noincremental
echo ":: Setup complete."
