# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"


# Would you like to use another custom folder than $ZSH/custom?
export ZSH_CUSTOM="$HOME/.zsh/"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
source $ZSH/oh-my-zsh.sh

# User configuration
 
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export FZF_DEFAULT_OPTS=‘—height=40% —preview=“cat {}” —preview-window=right:60%:wrap’

# PYENV_CONFIG
#export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

alias v="nvim"
alias gs="git status"
alias ga="git add"
alias gcm="git commit -m"
alias c="clear"

alias cpugetavail='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors'
alias cpushowcurrent='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias cpusethigh='echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'

if [[ "$OSTYPE" == "darwin"* ]]; then
  export POSH_DIR="$(brew --prefix oh-my-posh)"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export POSH_DIR="$HOME/.cache/oh-my-posh"
fi

# POSH_THEME="wholespace"
MY_THEME="${HOME}/dotfiles/myposh.omp.json"
# export THEME="tokyo"

export PATH=$PATH:$HOME/.local/bin
# eval "$(oh-my-posh --init --shell zsh --config $POSH_DIR/themes/$POSH_THEME.omp.json)"
eval "$(oh-my-posh --init --shell zsh --config ${MY_THEME})"
# echo ${MY_THEME}

# Ubuntu24 swap caps and ctrl
# gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"
#
# Ubuntu24 RESET SWAP
# gsettings reset org.gnome.desktop.input-sources xkb-options
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/home/nds/tools/Qt5.14.2/5.14.2/gcc_64/bin
export LD_LIBRARY_PATH=LD_LIBRARY_PATH$:/home/nds/tools/Qt5.14.2/5.14.2/gcc_64/lib

# source /opt/ros/jazzy/setup.zsh
# source /opt/ros/noetic/setup.zsh
# source ~/dev/catkin_ws/devel/setup.zsh
# source /opt/ros/foxy/setup.zsh
alias ross="source ~/dev/catkin_ws/devel/setup.zsh"
alias ross2="source /opt/ros/foxy/setup.zsh"

alias rossremote="export ROS_MASTER_URI=http://192.168.0.150:11311; export ROS_IP=192.168.0.102"
alias rosslocal="export ROS_MASTER_URI=http://localhost:11311; unset ROS_IP"
# export ROS_MASTER_URI=http://192.168.0.150:11311
# export ROS_IP=192.168.0.102
# export ROS_MASTER_URI=http://localhost:11311
# unset ROS_IP
