# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ─── Theme ───────────────────────────────────────────────────────────────────
# Set the theme. "powerlevel10k/powerlevel10k" gives a rich, fast prompt.
# Requires the Powerlevel10k repo cloned into $ZSH_CUSTOM/themes/powerlevel10k:
#   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
#     ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# ─── Powerlevel10k instant prompt ────────────────────────────────────────────
# Must be near the top of ~/.zshrc, before any output.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ─── Plugins ─────────────────────────────────────────────────────────────────
# Custom plugins must be cloned into $ZSH_CUSTOM/plugins/:
#
#   git clone https://github.com/zsh-users/zsh-autosuggestions \
#     ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#
#   git clone https://github.com/zsh-users/zsh-syntax-highlighting \
#     ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#
#   git clone https://github.com/zsh-users/zsh-completions \
#     ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
plugins=(
  git                      # git aliases and functions
  macos                    # macOS-specific helpers (tab, ofd, pfd, …)
  brew                     # Homebrew completions
  docker                   # Docker completions
  docker-compose           # Docker Compose completions
  npm                      # npm completions
  node                     # node version management helpers
  python                   # python helpers
  pip                      # pip completions
  virtualenv               # virtualenv prompt segment
  vscode                   # VS Code helpers (code, cde)
  kubectl                  # Kubernetes completions & aliases
  terraform                # Terraform completions
  gh                       # GitHub CLI completions
  fzf                      # fzf key bindings and fuzzy completion
  zsh-autosuggestions      # fish-like autosuggestions
  zsh-syntax-highlighting  # syntax highlighting while typing
  zsh-completions          # additional completions
  history-substring-search # up/down arrow searches history by substring
  colored-man-pages        # coloured man pages
  command-not-found        # suggest package when command is not found
  web-search               # search the web from the terminal
  copypath                 # copy current directory path to clipboard
  copyfile                 # copy file contents to clipboard
  dirhistory               # navigate directory history with alt+left/right
  extract                  # universal archive extraction with `x`
  z                        # jump to frecent directories
)

source "$ZSH/oh-my-zsh.sh"

# ─── Powerlevel10k config ─────────────────────────────────────────────────────
# Run `p10k configure` or edit ~/.p10k.zsh to customise the prompt.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ─── User configuration ───────────────────────────────────────────────────────

# Homebrew (Apple Silicon path takes precedence; Intel fallback included)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Language / locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor
export EDITOR="code --wait"   # VS Code; change to nvim/vim if preferred
export VISUAL="$EDITOR"

# ─── PATH additions ───────────────────────────────────────────────────────────
# Homebrew sbin
export PATH="/opt/homebrew/sbin:$PATH"

# macOS ships outdated tools; prefer Homebrew coreutils / gnu-sed / etc.
export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH" 2>/dev/null || true
export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"  2>/dev/null || true

# User local bin
export PATH="$HOME/.local/bin:$PATH"

# ─── History ─────────────────────────────────────────────────────────────────
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY          # write the history file in the :start:elapsed;command format
setopt HIST_EXPIRE_DUPS_FIRST    # expire duplicate entries first
setopt HIST_IGNORE_DUPS          # don't record a line already in history
setopt HIST_IGNORE_ALL_DUPS      # delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS         # do not display a line previously found
setopt HIST_IGNORE_SPACE         # don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS         # don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS        # remove superfluous blanks before recording
setopt SHARE_HISTORY             # share history between all sessions

# ─── Directory options ────────────────────────────────────────────────────────
setopt AUTO_CD           # type a directory name to cd into it
setopt AUTO_PUSHD        # cd pushes to the directory stack
setopt PUSHD_IGNORE_DUPS # don't push duplicates onto the stack
setopt PUSHD_SILENT      # don't print the directory stack after pushd/popd

# ─── Completion ──────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

# ─── Key bindings ────────────────────────────────────────────────────────────
# history-substring-search (requires the plugin above)
bindkey '^[[A' history-substring-search-up    # up arrow
bindkey '^[[B' history-substring-search-down  # down arrow

# ─── Aliases ─────────────────────────────────────────────────────────────────
# ── Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# ── Listing (use eza/lsd if available, fall back to ls)
if command -v eza &>/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -alh --icons --group-directories-first --git'
  alias lt='eza -T --icons --group-directories-first'        # tree
  alias la='eza -a --icons --group-directories-first'
else
  alias ls='ls -G'                            # colour on macOS
  alias ll='ls -alh'
  alias la='ls -a'
fi

# ── File operations (safer defaults)
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# ── Editor shortcuts
alias zshrc='$EDITOR ~/.zshrc'
alias zshrcs='source ~/.zshrc'
alias p10krc='$EDITOR ~/.p10k.zsh'

# ── Git shortcuts (beyond the Oh My Zsh git plugin)
alias glog="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
alias gst='git status -sb'
alias gdiff='git diff --word-diff'

# ── macOS convenience
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder; echo "DNS flushed"'
alias cleanup='find . -name ".DS_Store" -delete && echo "DS_Store files removed"'
alias brewup='brew update && brew upgrade && brew cleanup'
alias pubip='curl -s https://api.ipify.org && echo'
alias localip='ipconfig getifaddr en0'

# ── Networking
alias ports='lsof -i -P -n | grep LISTEN'
alias pingg='ping 8.8.8.8'

# ── Docker shortcuts
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dpa='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dstop='docker stop $(docker ps -q)'
alias drm='docker rm $(docker ps -aq)'
alias dprune='docker system prune -af'

# ── Development helpers
alias serve='python3 -m http.server 8000'   # quick static file server
alias json='python3 -m json.tool'           # pretty-print JSON

# ─── Functions ───────────────────────────────────────────────────────────────

# Create a directory and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# Quick look at a file
ql() { qlmanage -p "$@" &>/dev/null; }

# fzf-powered cd: fuzzy-find a directory and jump to it
fcd() {
  local dir
  dir=$(find "${1:-.}" -type d 2>/dev/null | fzf --preview 'ls {}') && cd "$dir"
}

# Open a GitHub repository in the browser from a local clone
ghopen() {
  local url
  url=$(git remote get-url origin 2>/dev/null \
    | sed 's|git@github.com:|https://github.com/|' \
    | sed 's|\.git$||')
  [[ -n "$url" ]] && open "$url" || echo "Not a Git repository with a GitHub remote"
}

# ─── Node Version Manager (nvm) ──────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ─── pyenv ───────────────────────────────────────────────────────────────────
if command -v pyenv &>/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# ─── rbenv ───────────────────────────────────────────────────────────────────
if command -v rbenv &>/dev/null; then
  eval "$(rbenv init - zsh)"
fi

# ─── Go ──────────────────────────────────────────────────────────────────────
if command -v go &>/dev/null; then
  export GOPATH="$HOME/go"
  export PATH="$GOPATH/bin:$PATH"
fi

# ─── Rust / Cargo ────────────────────────────────────────────────────────────
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# ─── fzf ─────────────────────────────────────────────────────────────────────
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
  --height 40% --layout=reverse --border
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
'

# ─── zoxide (smarter cd) ─────────────────────────────────────────────────────
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# ─── SSH agent ───────────────────────────────────────────────────────────────
# Load SSH keys stored in macOS Keychain
ssh-add --apple-load-keychain 2>/dev/null || true
