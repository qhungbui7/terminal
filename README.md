# terminal

MacBook terminal configuration using [Oh My Zsh](https://ohmyz.sh/).

## What's included

| Area | Details |
|---|---|
| **Theme** | [Powerlevel10k](https://github.com/romkatv/powerlevel10k) – fast, highly configurable prompt with instant-prompt support |
| **Plugins** | `git`, `macos`, `brew`, `docker`, `fzf`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-completions`, `z`, `extract`, and more |
| **History** | 50,000 entries, deduplication, shared across sessions |
| **Aliases** | Navigation, listing (eza), git, Docker, macOS helpers |
| **Functions** | `mkcd`, `extract`, `fcd` (fuzzy cd), `ghopen`, `ql` |
| **Runtimes** | nvm (Node), pyenv (Python), rbenv (Ruby), Go, Rust/Cargo |
| **Tools** | fzf (fuzzy finder), zoxide (smart cd) |

## Prerequisites

```bash
# 1. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 3. Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# 4. Custom plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-completions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

# 5. Recommended CLI tools (optional but used in the config)
brew install eza fzf fd zoxide
$(brew --prefix)/opt/fzf/install   # install fzf key bindings
```

## Installation

```bash
# Back up your existing config (if any)
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.bak

# Copy the config
cp .zshrc ~/.zshrc

# Reload
source ~/.zshrc
```

## Customise the prompt

Run the interactive wizard to generate `~/.p10k.zsh`:

```bash
p10k configure
```

## Key aliases

| Alias | Command |
|---|---|
| `ll` | Long listing with icons, git info (eza) |
| `lt` | Directory tree (eza) |
| `brewup` | `brew update && brew upgrade && brew cleanup` |
| `flushdns` | Flush macOS DNS cache |
| `cleanup` | Remove `.DS_Store` files recursively |
| `dps` / `dpa` | Docker ps with a clean table format |
| `glog` | Pretty git log graph |
| `serve` | Spin up a local HTTP server on port 8000 |
| `zshrc` | Open `~/.zshrc` in your `$EDITOR` |
| `zshrcs` | `source ~/.zshrc` |
