<div align="center">

<table border="0">
  <tr>
      <img src="assets/arch-logo.svg" width="150" height="150"/>
      <img src="https://capsule-render.vercel.app/api?type=blur&height=300&color=0:1793D1,100:b678c4&fontColor=CCA9DD&text=My%20Dotfiles&fontSize=130" height="150" width="400" />
    </td>
  </tr>
</table>
*My personal Arch Linux dotfiles — automated for easy setup.*

> [!TIP]
> **The Audiophile's Soul**: This setup is built with a deep appreciation for high-fidelity music. Unlike generic desktops, every layer of this system—from the TUI clients to the dynamic status island—is tuned to prioritize a premium, distraction-free listening experience.

<br><br/>
<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-A6DAF7?style=for-the-badge&logo=arch-linux&logoColor=1E1E2E"/>
  <img src="https://img.shields.io/badge/Hyprland-94E2D5?style=for-the-badge&logo=wayland&logoColor=1E1E2E"/>
  <img src="https://img.shields.io/badge/Mewline-F5C2E7?style=for-the-badge&logo=python&logoColor=1E1E2E"/>
  <img src="https://img.shields.io/badge/Zsh-F9E2AF?style=for-the-badge&logo=gnu-bash&logoColor=1E1E2E"/>
  <img src="https://img.shields.io/badge/GNU_Stow-CBA6F7?style=for-the-badge&logo=gnu&logoColor=1E1E2E"/>
</p>

</div>

---

<a id="gallery"></a>
<img src="https://readme-typing-svg.herokuapp.com?font=Lexend+Giga&size=25&pause=1000&color=CCA9DD&vCenter=true&width=435&height=25&lines=GALLERY" width="450"/>

<div align="center">
<table><tr><td>
<img src="assets/1.png" width="400"/>
</td><td>
<img src="assets/2.png" width="400"/>
</td></tr><tr><td>
<img src="assets/3.png" width="400"/>
</td><td>
<img src="assets/4.png" width="400"/>
</td></tr><tr><td>
<img src="assets/5.png" width="400"/>
</td><td>
<img src="assets/6.png" width="400"/>
</td></tr><tr><td>
<img src="assets/7.png" width="400"/>
</td><td>
<img src="assets/8.png" width="400"/>
</td></tr></table>
</div>

---

<a id="stack"></a>
<img src="https://readme-typing-svg.herokuapp.com?font=Lexend+Giga&size=25&pause=1000&color=CCA9DD&vCenter=true&width=435&height=25&lines=STACK" width="450"/>

| Category | Software |
|---|---|
| **Window Manager** | [Hyprland](https://hyprland.org) |
| **Status Bar** | [Mewline](https://github.com/meowrch/mewline) |
| **Terminal** | [Kitty](https://sw.kovidgoyal.net/kitty/) |
| **Shell** | ZSH + [Oh-My-Posh](https://ohmyposh.dev) |
| **Prompt Extras** | [Starship](https://starship.rs) |
| **Editor** | [Micro](https://micro-editor.github.io) / [Neovim](https://neovim.io) |
| **File Manager** | [Yazi](https://github.com/sxyazi/yazi) / [Nemo](https://github.com/linuxmint/nemo) |
| **App Launcher** | [Rofi](https://github.com/davatorium/rofi) |
| **Notifications** | [Dunst](https://dunst-project.org) / [SwayNC](https://github.com/ErikReider/SwayNotificationCenter) |
| **Multiplexer** | [Tmux](https://github.com/tmux/tmux) |
| **System Monitor** | [Btop](https://github.com/aristocratos/btop) |
| **Music Server** | [MPD](https://www.musicpd.org/) |
| **Music Client** | [RMPC](https://mierak.github.io/rmpc/) / [MPC](https://linux.die.net/man/1/mpc) |
| **Fetch** | [Fastfetch](https://github.com/fastfetch-cli/fastfetch) |
| **Config Manager** | [GNU Stow](https://www.gnu.org/software/stow) |

---

<a id="installation"></a>
<img src="https://readme-typing-svg.herokuapp.com?font=Lexend+Giga&size=25&pause=1000&color=CCA9DD&vCenter=true&width=435&height=25&lines=INSTALLATION" width="450"/>

Works on any fresh **Arch Linux** or Arch-based installation:

```bash
git clone https://github.com/abhinavflac/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh install.sh
```

> [!NOTE]
> Tested on **EndeavourOS** — should work on other Arch-based distros too.

---

<a id="what-it-does"></a>
<img src="https://readme-typing-svg.herokuapp.com?font=Lexend+Giga&size=25&pause=1000&color=CCA9DD&vCenter=true&width=435&height=25&lines=WHAT+INSTALL.SH+DOES" width="450"/>

The script handles everything in order:

```
Step 1/5 → Validates & installs native packages via pacman
Step 2/5 → Validates & installs AUR packages via yay (auto-bootstrapped if missing)
Step 3/5 → Removes unwanted pre-installed bloatware
Step 4/5 → Syncs custom Mewline source code → /opt/mewline/
Step 5/5 → Clears default config conflicts → links everything via GNU Stow
```
---

<a id="structure"></a>
<img src="https://readme-typing-svg.herokuapp.com?font=Lexend+Giga&size=25&pause=1000&color=CCA9DD&vCenter=true&width=435&height=25&lines=STRUCTURE" width="450"/>

```
dotfiles/
├── install.sh              # One-click restoration script
├── packages-native.txt     # pacman package list snapshot
├── packages-aur.txt        # AUR package list snapshot
├── remove-packages.txt     # Bloatware to purge on fresh install
├── custom-mewline/         # Full Mewline source (custom fork)
│   └── src/mewline/
│       └── constants.py
└── all-configs/            # GNU Stow root — maps to $HOME
    ├── .zshenv             # Sets ZDOTDIR for ZSH
    ├── .poshthemes/        # Oh-My-Posh shell theme
    └── .config/
        ├── hypr/           # Hyprland + Hyprlock + Hyprpaper
        ├── kitty/          # Terminal config
        ├── zsh/            # ZSH config + prompt + plugins
        ├── tmux/           # Tmux config
        ├── yazi/           # File manager config
        ├── rofi/           # App launcher theme
        ├── btop/           # System monitor config
        ├── fastfetch/      # Fetch config
        ├── dunst/          # Notification daemon
        ├── swaync/         # Notification center
        ├── mpd/            # Music Player Daemon config
        └── rmpc/           # Beautiful TUI music client config
```

---

<a id="workflow"></a>
<img src="https://readme-typing-svg.herokuapp.com?font=Lexend+Giga&size=25&pause=1000&color=CCA9DD&vCenter=true&width=435&height=25&lines=DAY-TO-DAY+WORKFLOW" width="450"/>

Since configs are symlinked via GNU Stow, edits inside `~/.config` automatically reflect in the repo.

To push your latest changes:

```bash
cd ~/dotfiles
git add .
git commit -m "update: description"
git push
```

Mewline changes require a manual sync since it lives in `/opt/`:

```bash
sudo rsync -a ~/dotfiles/custom-mewline/ /opt/mewline/
```

---

<a id="music-flow"></a>
<img src="https://readme-typing-svg.herokuapp.com?font=Lexend+Giga&size=25&pause=1000&color=CCA9DD&vCenter=true&width=435&height=25&lines=MUSIC+ARCHITECTURE" width="450"/>

The music system is built on a four-layer architecture for maximum control and aesthetic integration:

- **Layer 1: The Core (MPD)** → A high-performance daemon running in the background, serving high-fedelity audio via PipeWire.
- **Layer 2: The Command (MPC)** → A lightweight CLI used for global hotkeys (Play/Next/Prev) managed by Hyprland.
- **Layer 3: The Interaction (RMPC)** → A beautiful, rust-powered TUI client for managing playlists and browsing your library.
- **Layer 4: The Visual (Mewline)** → Dynamic Island integration via `mpd-mpris`, showing live track details and visualizers.

### 🎧 Navidrome & Google Drive Server
My dotfiles automatically provision a high-fidelity FLAC streaming server using Navidrome backed by a Google Drive rclone mount.

**Post-Installation Steps (One-Time Only):**
Because Google Drive credentials cannot be stored in GitHub, you must link your account once after a fresh install:
1. Run `rclone config` in your terminal.
2. Create a new remote and name it **exactly** `gdrive` (Select Google Drive, follow the browser prompts).
3. The background service (`rclone.service`) will now automatically mount your music to `~/gdrive`.
4. Run `cd ~/.config/navidrome && docker-compose up -d` to spin up your Navidrome server!

---

<div align="center">
  <p>🎨 Made with passion for the perfect rice <img src="assets/arch-logo.svg" width="18" style="vertical-align:middle"/> Arch btw</p>
</div>
