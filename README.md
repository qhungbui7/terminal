# terminal

MacBook terminal configuration using [Oh My Zsh](https://ohmyz.sh/), with extras for **Machine Learning engineers & researchers**.

## What's included

| Area | Details |
|---|---|
| **Theme** | [Powerlevel10k](https://github.com/romkatv/powerlevel10k) – fast, highly configurable prompt with instant-prompt support |
| **Plugins** | `git`, `macos`, `brew`, `docker`, `fzf`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-completions`, `z`, `extract`, and more |
| **History** | 50,000 entries, deduplication, shared across sessions |
| **Aliases** | Navigation, listing (eza), git, Docker, macOS helpers, **ML/GPU shortcuts** |
| **Functions** | `mkcd`, `extract`, `fcd` (fuzzy cd), `ghopen`, `ql` |
| **Runtimes** | nvm (Node), pyenv (Python), rbenv (Ruby), Go, Rust/Cargo |
| **Tools** | fzf (fuzzy finder), zoxide (smart cd) |
| **ML Tools** | Conda/Miniconda, GPU monitoring (`gpustat`, `nvtop`), Jupyter, experiment tracking |

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

---

## 🤖 ML Engineer / Researcher Setup

The sections below are curated for a machine learning workflow—Python environment management, GPU monitoring, experiment tracking, and handy shell shortcuts.

### Suggested packages & tools

#### Python environment — Miniconda (recommended)

Miniconda gives you `conda` without the bloat of full Anaconda.

```bash
# macOS (Apple Silicon)
brew install --cask miniconda

# Linux
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
```

Create a base ML environment:

```bash
conda create -n ml python=3.11 -y
conda activate ml
```

#### Core ML / data-science libraries

```bash
# PyTorch (pick the command that matches your hardware at https://pytorch.org)
# Example – CUDA 12.x on Linux:
pip install torch torchvision torchaudio

# TensorFlow (optional)
pip install tensorflow

# JAX (optional, for TPU / XLA research)
pip install jax jaxlib

# Data & scientific computing
pip install numpy pandas scipy matplotlib seaborn scikit-learn

# Jupyter
pip install jupyterlab ipywidgets notebook
```

#### Experiment tracking & MLOps

| Tool | Install | What it does |
|---|---|---|
| [Weights & Biases](https://wandb.ai) | `pip install wandb` | Experiment tracking, hyperparameter sweeps, model registry |
| [MLflow](https://mlflow.org) | `pip install mlflow` | Experiment logging, model packaging, serving |
| [TensorBoard](https://www.tensorflow.org/tensorboard) | `pip install tensorboard` | Training visualisation (works with PyTorch too) |
| [DVC](https://dvc.org) | `pip install dvc` | Data & model version control on top of Git |

#### GPU monitoring (Linux / NVIDIA)

```bash
# gpustat – compact GPU usage overview
pip install gpustat

# nvtop – interactive GPU process viewer (like htop for GPUs)
# Ubuntu / Debian
sudo apt install nvtop
# macOS (limited use; mainly for remote servers)
brew install nvtop
```

#### Useful CLI tools for ML work

```bash
# tmux – keep training sessions alive when you disconnect
brew install tmux            # macOS
sudo apt install tmux        # Linux

# htop – interactive process viewer
brew install htop

# ncdu – find large datasets / checkpoints eating your disk
brew install ncdu
```

### Suggested `.zshrc` additions

The following aliases and settings are already included in the `.zshrc` shipped with this repo.
If you maintain your own config, copy the blocks you find useful.

```bash
# ── Conda / Python ──────────────────────────────────────────
alias ca='conda activate'
alias cda='conda deactivate'
alias cel='conda env list'
alias cen='conda create -n'        # usage: cen myenv python=3.11
alias cer='conda env remove -n'    # usage: cer oldenv
alias pipr='pip install -r requirements.txt'

# ── Jupyter ─────────────────────────────────────────────────
alias jl='jupyter lab'
alias jn='jupyter notebook'

# ── GPU / NVIDIA (Linux) ────────────────────────────────────
alias gpus='gpustat --color -i 1'   # live GPU dashboard
alias nv='nvidia-smi'
alias nvw='watch -n 1 nvidia-smi'   # refresh nvidia-smi every second

# ── Experiment tracking ─────────────────────────────────────
alias tb='tensorboard --logdir'     # usage: tb ./runs
alias mlfs='mlflow ui'              # start MLflow UI

# ── Training helpers ────────────────────────────────────────
# Run a script and get a macOS/Linux notification when it finishes
train-notify() {
  "$@"
  local exit_code=$?
  if command -v osascript &>/dev/null; then
    osascript -e "display notification \"Exit code: $exit_code\" with title \"Training finished\""
  elif command -v notify-send &>/dev/null; then
    notify-send "Training finished" "Exit code: $exit_code"
  fi
  return $exit_code
}

# ── Remote servers (SSH) ────────────────────────────────────
# Add your GPU boxes here for quick access
# alias gpu1='ssh user@gpu-server-1'
# alias gpu2='ssh user@gpu-server-2'
```

### Recommended VS Code extensions

If you use VS Code (or the Remote-SSH extension to work on GPU servers):

- **Python** (`ms-python.python`)
- **Pylance** (`ms-python.vscode-pylance`)
- **Jupyter** (`ms-toolsai.jupyter`)
- **Remote - SSH** (`ms-vscode-remote.remote-ssh`)
- **GitLens** (`eamodio.gitlens`)
- **GitHub Copilot** (`GitHub.copilot`)

### Tips

- **Pin your CUDA version** — match the CUDA toolkit to the version your framework needs; mismatches cause hard-to-debug errors.
- **Use `tmux` on remote servers** — so your training survives SSH disconnections. `tmux new -s train` / `tmux attach -t train`.
- **Keep large data out of Git** — use DVC, Git LFS, or symlinks to external storage.
- **Version your environments** — export with `conda env export > environment.yml` or `pip freeze > requirements.txt` in every project.
