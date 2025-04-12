#! /bin/sh
rm -f ~/.zshrc

cd ~/dotfiles
git submodule update --init --recursive
stow --adopt .

echo "\n========================================"
echo "All done! Enjoy!"
echo "========================================"

