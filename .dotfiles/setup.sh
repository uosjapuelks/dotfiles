alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

git clone --bare git@github.com:uosjapuelks/.dotfiles.git $HOME/.dotfiles

dotfiles config --local status.showUntrackedFiles no
dotfiles checkout

