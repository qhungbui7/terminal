# 🖥️ Terminal – Oh My Zsh Config for MacBook

A curated, batteries-included [Oh My Zsh](https://ohmyz.sh/) configuration
tailored for macOS (Apple Silicon & Intel).

## ✨ What's Included

| Category | Highlights |
|---|---|
| **Theme** | [Agnoster](https://github.com/agnoster/agnoster-zsh-theme) (swap to Powerlevel10k easily) |
| **Plugins** | git · macos · brew · docker · kubectl · node · npm · python · z · fzf integration |
| **Custom plugins** | zsh-autosuggestions · zsh-syntax-highlighting · zsh-history-substring-search |
| **Aliases** | Navigation, Git, Docker, macOS utilities (Finder, DNS, lock screen, Trash) |
| **Functions** | `mkcd`, `ex` (extract any archive), `ff`/`fdir` (find files/dirs), `weather`, `serve` |
| **Tool integrations** | Homebrew, nvm, pyenv, rbenv, fzf, thefuck – loaded only when present |
| **History** | 50 000 entries, shared across sessions, duplicate-free |
| **Completions** | Case-insensitive, coloured, menu-select, cached |
| **Local overrides** | `~/.zshrc.local` sourced automatically for machine-specific settings |

## 🚀 Quick Start

```bash
# Clone the repo
git clone https://github.com/qhungbui7/terminal.git ~/terminal-config
cd ~/terminal-config

# Run the installer
bash install.sh
```

The installer will:

1. Install **Homebrew** (if not already installed)
2. Install **Oh My Zsh** (if not already installed)
3. Clone the three custom plugins
4. Install useful CLI tools via Homebrew (`eza`, `bat`, `fzf`, `ripgrep`, `fd`, `jq`, `htop`, …)
5. Install **MesloLGS Nerd Font** for icon support
6. Back up your existing `~/.zshrc` and copy the new one into place

## 📁 Files

```
.
├── .zshrc        # Main Zsh configuration
├── install.sh    # One-command setup script
└── README.md     # You are here
```

## ⚙️ Customisation

- **Theme** – Change `ZSH_THEME` at the top of `.zshrc`. Recommended:
  [Powerlevel10k](https://github.com/romkatv/powerlevel10k).
- **Plugins** – Add or remove entries in the `plugins=(…)` array.
- **Local overrides** – Create `~/.zshrc.local` for secrets, tokens, or
  machine-specific PATH additions. It's sourced automatically and should
  **not** be committed.

## 🔑 Useful Shortcuts

| Shortcut | Action |
|---|---|
| `⌥ ←` / `⌥ →` | Move cursor word-by-word |
| `⌥ ⌫` | Delete previous word |
| `↑` / `↓` | History substring search |
| `reload` | Re-source `~/.zshrc` |
| `myip` / `localip` | Show public / local IP |
| `showfiles` / `hidefiles` | Toggle hidden files in Finder |
| `flushdns` | Flush macOS DNS cache |

## 📝 License

This project is provided as-is for personal use. Feel free to fork and adapt.
