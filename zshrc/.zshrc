# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$PATH:~/.emacs.d/bin/
export PATH="${PATH}:${HOME}/.local/bin/"
export PATH=$PATH:/opt/homebrew/Cellar/python@3.9/3.9.10/Frameworks/Python.framework/Versions/3.9/bin/
export PATH=$PATH:/Users/lucaskerbs/Library/Python/3.11/bin
export PATH=$PATH:/Applications/Alacritty.app/Contents/MacOS/alacritty
# User configuration

EDITOR='nvim'

function brew() {
  command brew "$@"

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_upgrade
  fi
}

function mas() {
  command mas "$@"

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_upgrade
  fi
}

function push() {
  command git push
  sketchybar --trigger git_push
}


alias convim=" cd ~/.config/nvim && nvim"


export PATH="/opt/homebrew/opt/node@18/bin:$PATH"
export PATH="/Applications/Alacritty.app/Contents/MacOS/alacritty:$PATH"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

# History Settings
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# ---- Set up aliases for cd and ls -------

alias cd="z"
alias ls="eza --icons=always"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
