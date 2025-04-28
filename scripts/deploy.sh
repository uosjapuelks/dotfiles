#!/bin/bash
set -ex
# set -u
set -o pipefail

# Default values
ARCH=$(uname -m)
NEOVIM_VERSION=v0.10.0
NEOVIM_PATH=~/dev_tools/neovim/
NODEJS_VERSION=18.18.2
while [[ "${1}" ]]; do
  case "${1}" in
  -v|--version)
    shift
    if [[ "${1}" ]]; then
      NEOVIM_VERSION="${1}"
    else
      echo "Error: Version argument missing after -v or --version."
      exit 1
    fi
    ;;
  -p|--path)
    shift
if [[ "${1}" ]]; then
      NEOVIM_PATH="${1}"
    else
      echo "Error: Path argument missing after -p or --path."
      exit 1
    fi
    ;;
  --)
    shift
    break
    ;;
  *)
    echo "Unknown option: ${1}"
    exit 1
    ;;
  esac
  shift
done


echo "========================================"
echo "Installing Neovim version ${NEOVIM_VERSION} to ${NEOVIM_PATH}"
read -rp "Press Enter to continue..."
echo "========================================"

echo "Installing pre-requisites"
sudo apt-get update
#
sudo apt-get install -y clang \
    clang-tidy \
    clang-format \
    cmake \
    curl \
    gdb \
    git \
    gettext \
    ninja-build \
    nodejs \
    npm \
    python3-pip \
    python3-venv \
    ripgrep \
    wget \
    tar \
    unzip \
    stow

pip3 install black debugpy ruff

# This is needed to get pyright working
echo "========================================"
echo "Configuring nodejs"
if [[ $ARCH=="aarch64" ]]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
else
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
fi
bash -c ". ${HOME}/.nvm/nvm.sh && nvm install v${NODEJS_VERSION} && nvm use ${NODEJS_VERSION}"

echo "========================================"
echo "Installing lazygit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz

echo "========================================"
#
echo "Installing neovim"
if [[ ! -d "${NEOVIM_PATH}" ]];then
  REPOSITORY_URL="https://github.com/neovim/neovim"
  if ! (git ls-remote --heads "${REPOSITORY_URL}" "${NEOVIM_VERSION}" | grep -q "${NEOVIM_VERSION}" || \
        git ls-remote --tags "${REPOSITORY_URL}" "${NEOVIM_VERSION}" | grep -q "refs/tags/${NEOVIM_VERSION}"); then
      echo "Branch or tag '${NEOVIM_VERSION}' does not exist in the remote repository."
  fi
  git clone "${REPOSITORY_URL}" "${NEOVIM_PATH}" -b "${NEOVIM_VERSION}"

  (
    cd "${NEOVIM_PATH}" || exit 1
    make CMAKE_BUILD_TYE=RelWithDebInfo
    sudo make install
  )
fi

echo "========================================"
echo "Configuring Neovim"

nvim --headless "+Lazy! sync" +qa

echo "\n========================================"
echo "All done!"
echo "Have fun developing with neovim!"
echo "========================================"

sudo apt install tree curl

# FONT
echo "\n========================================"
echo "Installing FONTS (Meslo)"
echo "========================================"
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Meslo.zip \
&& cd ~/.local/share/fonts \
&& unzip Meslo.zip \
&& rm Meslo.zip \
&& fc-cache -fv

sudo apt install ripgrep fzf fd-find
sudo apt install gcc clangd

# Ubuntu24 swap caps and ctrl
# gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"
#
# Ubuntu24 RESET SWAP
# gsettings reset org.gnome.desktop.input-sources xkb-options

# Install zsh
echo "\n========================================"
echo "Installing Zsh and Oh My Posh! (Meslo)"
echo "========================================"
sudo apt install zsh
# Install Oh My Posh
if [[ "$OSTYPE" == "darwin"* ]]; then
  brew install jandedobbeleer/oh-my-posh/oh-my-posh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  curl -s https://ohmyposh.dev/install.sh | bash -s
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
