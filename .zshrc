# =============================================================================
#  Oh My Zsh Configuration for MacBook
# =============================================================================

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# -----------------------------------------------------------------------------
#  Theme
# -----------------------------------------------------------------------------
# Using "agnoster" as default; switch to "powerlevel10k/powerlevel10k" if
# you install Powerlevel10k (recommended for a richer prompt experience).
ZSH_THEME="agnoster"

# Hide the default user@host when you're logged in as yourself
DEFAULT_USER="$(whoami)"

# -----------------------------------------------------------------------------
#  Plugin Configuration  (set BEFORE sourcing Oh My Zsh)
# -----------------------------------------------------------------------------

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# History substring search – bind to Up/Down arrows after sourcing
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=cyan,fg=white,bold"

# Uncomment to change auto-update behavior
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' frequency 14   # days between auto-updates

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# -----------------------------------------------------------------------------
#  Plugins
# -----------------------------------------------------------------------------
# Standard plugins live in $ZSH/plugins/
# Custom plugins live in $ZSH_CUSTOM/plugins/
#
# After first run, install community plugins with:
#   git clone https://github.com/zsh-users/zsh-autosuggestions \
#       ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#   git clone https://github.com/zsh-users/zsh-syntax-highlighting \
#       ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#   git clone https://github.com/zsh-users/zsh-history-substring-search \
#       ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

plugins=(
  git                          # Git aliases & functions (e.g., gst, gco, gp)
  macos                        # macOS helpers: ofd, cdf, quick-look, etc.
  brew                         # Homebrew completions & aliases
  docker                       # Docker completions & aliases
  docker-compose               # Docker Compose completions
  kubectl                      # Kubernetes completions & aliases
  node                         # Node.js helpers (node-hierarchical-search, etc.)
  npm                          # npm completions & aliases
  python                       # Python aliases (pyfind, pygrep, pyclean)
  pip                          # pip completions & aliases
  z                            # Frecency-based directory jumping
  colored-man-pages            # Adds colour to man pages
  command-not-found            # Suggests package to install for unknown commands
  common-aliases               # Helpful shell aliases (la, ll, etc.)
  extract                      # `extract` any archive with one command
  zsh-autosuggestions          # Fish-like autosuggestions  (custom plugin)
  zsh-syntax-highlighting      # Real-time syntax highlighting (custom plugin)
  zsh-history-substring-search # Type & arrow-up to search history (custom plugin)
)

# Source Oh My Zsh (must come after plugin list)
source "$ZSH/oh-my-zsh.sh"

# -----------------------------------------------------------------------------
#  History Configuration
# -----------------------------------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY          # Record timestamp of each command
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first
setopt HIST_IGNORE_DUPS          # Don't record consecutive duplicates
setopt HIST_IGNORE_ALL_DUPS      # Remove older duplicate entries
setopt HIST_IGNORE_SPACE         # Don't record commands starting with a space
setopt HIST_FIND_NO_DUPS         # Don't display duplicates during search
setopt HIST_REDUCE_BLANKS        # Remove extra blanks from each command
setopt HIST_VERIFY               # Show command with history expansion before running
setopt SHARE_HISTORY             # Share history between all sessions
setopt INC_APPEND_HISTORY        # Add commands immediately (not at shell exit)

# -----------------------------------------------------------------------------
#  Key Bindings
# -----------------------------------------------------------------------------
# Use Emacs-style key bindings (default on macOS)
bindkey -e

# History substring search with arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Option + Left/Right to move word by word in iTerm2 / Terminal.app
bindkey '^[b' backward-word
bindkey '^[f' forward-word

# Option + Backspace to delete word
bindkey '^[^?' backward-kill-word

# Home / End
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# -----------------------------------------------------------------------------
#  Homebrew
# -----------------------------------------------------------------------------
# Apple Silicon Macs install Homebrew to /opt/homebrew
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
# Intel Macs use /usr/local
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# -----------------------------------------------------------------------------
#  PATH Additions
# -----------------------------------------------------------------------------
# Add common tool paths (de-duplicated automatically by typeset -U)
typeset -U path
path=(
  $HOME/bin
  $HOME/.local/bin
  $HOME/go/bin
  $HOME/.cargo/bin
  $path
)

# -----------------------------------------------------------------------------
#  Environment Variables
# -----------------------------------------------------------------------------
export EDITOR="vim"
export VISUAL="code"                 # Use VS Code for visual editor
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Less – make it friendlier
export LESS="-R -F -X"

# Coloured GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# -----------------------------------------------------------------------------
#  Completion Tweaks
# -----------------------------------------------------------------------------
# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Menu-select for completions
zstyle ':completion:*' menu select

# Coloured completion listings
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Cache completions for speed
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"

# -----------------------------------------------------------------------------
#  Aliases – General
# -----------------------------------------------------------------------------
# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Listing (use eza if available, otherwise ls with colour)
if command -v eza &>/dev/null; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza -alh --icons --group-directories-first"
  alias lt="eza --tree --level=2 --icons"
else
  alias ls="ls --color=auto"
  alias ll="ls -alh"
fi

alias la="ls -A"
alias l="ls -CF"

# Safety nets
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Grep with colour
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Disk usage
alias df="df -h"
alias du="du -h"

# Clear screen
alias cls="clear"

# Quick reload
alias reload="source ~/.zshrc && echo '✅ ~/.zshrc reloaded'"

# IP address
alias myip="curl -s https://ifconfig.me && echo"
alias localip="ipconfig getifaddr en0"

# Show/hide hidden files in Finder
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Flush DNS cache (macOS)
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder; echo '✅ DNS cache flushed'"

# Lock the screen
alias lockscreen="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Empty the Trash on all mounted volumes and the main HDD
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# -----------------------------------------------------------------------------
#  Aliases – Git  (supplements the git plugin)
# -----------------------------------------------------------------------------
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gp="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gb="git branch"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --oneline --graph --decorate -20"
alias gla="git log --oneline --graph --decorate --all"

# -----------------------------------------------------------------------------
#  Aliases – Docker
# -----------------------------------------------------------------------------
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dimg="docker images"
alias drm="docker rm"
alias drmi="docker rmi"
alias dstop="docker stop"
alias dstart="docker start"

# -----------------------------------------------------------------------------
#  Functions
# -----------------------------------------------------------------------------

# Create a directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract any archive
ex() {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1"   ;;
      *.tar.gz)  tar xzf "$1"   ;;
      *.tar.xz)  tar xJf "$1"   ;;
      *.bz2)     bunzip2 "$1"   ;;
      *.rar)     unrar x "$1"   ;;
      *.gz)      gunzip "$1"    ;;
      *.tar)     tar xf "$1"    ;;
      *.tbz2)    tar xjf "$1"   ;;
      *.tgz)     tar xzf "$1"   ;;
      *.zip)     unzip "$1"     ;;
      *.Z)       uncompress "$1";;
      *.7z)      7z x "$1"      ;;
      *)         echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Quickly find files
ff() {
  find . -type f -iname "*$1*"
}

# Quickly find directories
fd() {
  find . -type d -iname "*$1*"
}

# Get the weather
weather() {
  curl "https://wttr.in/${1:-}"
}

# Determine the size of a file or total size of a directory
fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* ./*
  fi
}

# Simple HTTP server from current directory
serve() {
  local port="${1:-8000}"
  echo "Serving on http://localhost:$port"
  python3 -m http.server "$port"
}

# -----------------------------------------------------------------------------
#  Tool Integrations (loaded only when present)
# -----------------------------------------------------------------------------

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# pyenv
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# rbenv
if command -v rbenv &>/dev/null; then
  eval "$(rbenv init - zsh)"
fi

# fzf – fuzzy finder
if command -v fzf &>/dev/null; then
  source <(fzf --zsh 2>/dev/null) || true
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"
  if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
fi

# thefuck – corrects previous console command
if command -v thefuck &>/dev/null; then
  eval "$(thefuck --alias)"
fi

# Zoxide – smarter cd (alternative to z plugin)
# Uncomment the following if you prefer zoxide over the z plugin:
# if command -v zoxide &>/dev/null; then
#   eval "$(zoxide init zsh)"
#   alias cd="z"
# fi

# -----------------------------------------------------------------------------
#  Local Overrides
# -----------------------------------------------------------------------------
# Source a local file for machine-specific settings that shouldn't be committed
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
