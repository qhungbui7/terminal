#!/usr/bin/env bash
# =============================================================================
#  Oh My Zsh MacBook Setup Script
#  Run: bash install.sh
# =============================================================================
set -euo pipefail

# Ensure script is executed, not sourced
if [[ "${BASH_SOURCE[0]}" != "$0" ]]; then
  echo "Error: This script should be executed, not sourced."
  echo "Usage: bash install.sh"
  return 1
fi

BOLD="\033[1m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
RESET="\033[0m"

info()  { echo -e "${GREEN}[INFO]${RESET}  $*"; }
warn()  { echo -e "${YELLOW}[WARN]${RESET}  $*"; }
error() { echo -e "${RED}[ERROR]${RESET} $*"; }

# ---------------------------------------------------------------------------
#  1. Check prerequisites
# ---------------------------------------------------------------------------
if [[ "$(uname)" != "Darwin" ]]; then
  warn "This script is designed for macOS. Proceed with caution."
fi

# ---------------------------------------------------------------------------
#  2. Install Homebrew (if missing)
# ---------------------------------------------------------------------------
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew …"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Make brew available in current session
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  info "Homebrew already installed ✔"
fi

# ---------------------------------------------------------------------------
#  3. Install Oh My Zsh (if missing)
# ---------------------------------------------------------------------------
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  info "Installing Oh My Zsh …"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  info "Oh My Zsh already installed ✔"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ---------------------------------------------------------------------------
#  4. Install custom plugins
# ---------------------------------------------------------------------------
declare -A PLUGINS=(
  ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
  ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting"
  ["zsh-history-substring-search"]="https://github.com/zsh-users/zsh-history-substring-search"
)

for plugin in "${!PLUGINS[@]}"; do
  dest="$ZSH_CUSTOM/plugins/$plugin"
  if [[ ! -d "$dest" ]]; then
    info "Installing plugin: $plugin"
    git clone --depth=1 "${PLUGINS[$plugin]}" "$dest"
  else
    info "Plugin $plugin already installed ✔"
  fi
done

# ---------------------------------------------------------------------------
#  5. Install recommended Homebrew packages
# ---------------------------------------------------------------------------
BREW_PACKAGES=(
  eza           # Modern ls replacement
  bat           # Cat with syntax highlighting
  fzf           # Fuzzy finder
  ripgrep       # Fast grep
  fd            # Fast find
  tree          # Directory listing
  jq            # JSON processor
  htop          # System monitor
  tldr          # Simplified man pages
  wget          # Download files
)

info "Installing recommended Homebrew packages …"
for pkg in "${BREW_PACKAGES[@]}"; do
  if ! brew list "$pkg" &>/dev/null; then
    brew install "$pkg" || warn "Failed to install $pkg"
  else
    info "  $pkg already installed ✔"
  fi
done

# ---------------------------------------------------------------------------
#  6. Install a Nerd Font (for icons in prompt / eza)
# ---------------------------------------------------------------------------
if ! brew list --cask font-meslo-lg-nerd-font &>/dev/null 2>&1; then
  info "Installing MesloLGS Nerd Font …"
  brew install --cask font-meslo-lg-nerd-font || warn "Font install failed – install manually from https://www.nerdfonts.com"
else
  info "Nerd Font already installed ✔"
fi

# ---------------------------------------------------------------------------
#  7. Back up existing .zshrc and copy ours
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -f "$HOME/.zshrc" ]]; then
  BACKUP="$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
  warn "Backing up existing ~/.zshrc → $BACKUP"
  cp "$HOME/.zshrc" "$BACKUP"
fi

info "Copying .zshrc to $HOME/.zshrc"
cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"

# ---------------------------------------------------------------------------
#  8. Done!
# ---------------------------------------------------------------------------
echo ""
echo -e "${BOLD}${GREEN}✅ Installation complete!${RESET}"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal  (or run: source ~/.zshrc)"
echo "  2. Set your terminal font to 'MesloLGS NF' for icon support"
echo "  3. (Optional) Create ~/.zshrc.local for machine-specific settings"
echo ""
echo "Enjoy your new shell! 🚀"
