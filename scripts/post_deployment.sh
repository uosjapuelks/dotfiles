#! /bin/sh
rm -f ~/.zshrc

cd ~/dotfiles
git submodule update --init --recursive
stow --adopt .

if [[ "$OSTYPE" == "darwin"* ]]; then
  # brew install jandedobbeleer/oh-my-posh/oh-my-posh
elif [[ "OSTYPE" == "linux-gnu"* ]]; then
  sudo apt-get install clangd
  pip3 install cpplint
  
  ln /usr/bin/clangd ~/.local/share/nvim/mason/bin/clangd
  ln /usr/bin/cpplint ~/.local/share/nvim/mason/bin/cpplint
  cd ~/.local/share/nvim/mason/packages/
  mkdir clangd
  mkdir cpplint
  
fi

echo "\n========================================"
echo "All done! Enjoy!"
echo "========================================"

