FROM ubuntu:24.04

ARG VERSION="v6.11"

WORKDIR /root

RUN apt-get update && apt-get install -y \
  software-properties-common \
  && add-apt-repository ppa:neovim-ppa/stable \
  && apt-get install -y \
  curl \
  unzip \
  build-essential \
  libssl-dev \
  libncurses-dev \
  make \
  universal-ctags \
  cscope \
  flex \
  bison \
  bc \
  clang \
  clangd \
  git \
  neovim \
  fzf \
  ripgrep \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN git clone --branch ${VERSION} --depth 1 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ./linux

WORKDIR /root/linux

RUN ctags -R . && cscope -Rb
RUN make oldconfig
RUN make -j$(nproc) CC=clang all compile_commands.json

# neovim
COPY nvim/init.lua /root/.config/nvim/init.lua
RUN git clone --branch stable --depth 1 https://github.com/folke/lazy.nvim.git /root/.local/share/nvim/lazy/lazy.nvim

# clangd
COPY clangd/clangd /root/.clangd

ENTRYPOINT ["/bin/bash"]
