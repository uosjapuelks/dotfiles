sudo apt install tree curl

# FONT
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Meslo.zip \
&& cd ~/.local/share/fonts \
&& unzip Meslo.zip \
&& rm Meslo.zip \
&& fc-cache -fv

sudo apt install ripgrep fzf fd-find
sudo apt install gcc clang

# Ubuntu24 swap caps and ctrl
# gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"

# Install zsh
sudo apt install zsh
chsh zsh

# Install Oh My Posh
curl -s https://ohmyposh.dev/install.sh | bash -s
