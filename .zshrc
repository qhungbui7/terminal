export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Show execution time for commands > 1s
REPORTTIME=1

# Zoxide
eval "$(zoxide init zsh)"

# Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^R' fzf-history-widget

# ── ML / Data-Science Aliases ───────────────────────────────

# Conda / Python
alias ca='conda activate'
alias cda='conda deactivate'
alias cel='conda env list'
alias cen='conda create -n'        # usage: cen myenv python=3.11
alias cer='conda env remove -n'    # usage: cer oldenv
alias pipr='pip install -r requirements.txt'

# Jupyter
alias jl='jupyter lab'
alias jn='jupyter notebook'

# GPU / NVIDIA (Linux)
alias gpus='gpustat --color -i 1'   # live GPU dashboard
alias nv='nvidia-smi'
alias nvw='watch -n 1 nvidia-smi'   # refresh nvidia-smi every second

# Experiment tracking
alias tb='tensorboard --logdir'     # usage: tb ./runs
alias mlfs='mlflow ui'              # start MLflow UI

# Run a command and get a desktop notification when it finishes
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

# Conda initialisation (uncomment if conda is installed)
# eval "$(conda shell.zsh hook)"
