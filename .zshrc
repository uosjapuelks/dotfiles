# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

#export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init --path)"
#eval "$(pyenv virtualenv-init -)"

# plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

# export FZF_DEFAULT_OPTS=‘—height=40% —preview=“cat {}” —preview-window=right:60%:wrap’

alias v="nvim"
alias gs="git status"
alias ga="git add"
alias gcm="git commit -m"

export PATH=$PATH:$HOME/.local/bin
if [ "$OSTYPE" != "darwin22.0" ]; then
  eval "$(oh-my-posh --init --shell zsh --config $HOME/.cache/oh-my-posh/themes/wholespace.omp.json)"
else
  eval "$(oh-my-posh --init --shell zsh --config $(brew --prefix oh-my-posh)/themes/clean-detailed.omp.json)"
fi

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Ubuntu24 swap caps and ctrl
# gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"
#
# Ubuntu24 RESET SWAP
# gsettings reset org.gnome.desktop.input-sources xkb-options
#
# source /opt/ros/jazzy/setup.zsh
