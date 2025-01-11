# Common

## Generate SSH key

```
> ssh-keygen -t ed25519
```

## Install packages

### Basics

- git: https://git-scm.com/
- wezterm: https://wezfurlong.org/wezterm/installation
- fish: https://fishshell.com/
- fisher: https://github.com/jorgebucaran/fisher#installation
  - `cat "~/.dotfiles/packages/fisher_list" | fisher install`
- tmux: https://github.com/tmux/tmux/wiki/Installing
- tpm: https://github.com/tmux-plugins/tpm#installation
  - `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
  - `prefix` + `I`
- neovim: https://neovim.io/
  - 0.9 버전 이상(unstable)을 설치하도록 한다.
- vim-plug: https://github.com/junegunn/vim-plug#installation

### Development

- nvm: https://github.com/nvm-sh/nvm#installing-and-updating
  - `nvm install <version>`
- pyenv: https://github.com/pyenv/pyenv#installation
  - `pyenv install <version>`
- rust: https://www.rust-lang.org/tools/install

### Node packages

- pnpm: https://pnpm.io/installation
- pm2: https://pm2.keymetrics.io/docs/usage/quick-start/#installation
  - `npm install -g pm2@latest`
- bash-language-server: https://github.com/bash-lsp/bash-language-server#installation
  - `npm install -g bash-language-server`
- korean-ls: https://github.com/aca/korean-language-server#Installation
  - `npm install -g korean-ls`

### Fonts

- nerd-fonts: https://github.com/ryanoasis/nerd-fonts#font-installation
  - `curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/RobotoMono.tar.xz`

### CLI Tools

- fzf: https://github.com/junegunn/fzf#installation
- lsd: https://github.com/lsd-rs/lsd#installation
- bat: https://github.com/sharkdp/bat#installation
- fd: https://github.com/sharkdp/fd#installation
- ripgrep: https://github.com/BurntSushi/ripgrep#installation
- delta: https://dandavison.github.io/delta/installation.html
- dust: https://github.com/bootandy/dust#install
- procs: https://github.com/dalance/procs#installation
- tldr: https://dbrgn.github.io/tealdeer/installing.html
- trash-cli: https://github.com/sindresorhus/trash-cli#install

## Make symbolic links

```
> set DOTFILES_DIR <path>

# git
> ln -s $DOTFILES_DIR/.gitconfig ~/.gitconfig
> ln -s $DOTFILES_DIR/.delta-themes.gitconfig ~/.delta-themes.gitconfig

# wezterm
> ln -s $DOTFILES_DIR/wezterm.lua ~/.config/wezterm/wezterm.lua
> ln -s $DOTFILES_DIR/wezterm-dracula.toml ~/.config/wezterm/wezterm-dracula.toml

# fish
> ln -s $DOTFILES_DIR/config.fish ~/.config/fish/config.fish
> ln -s $DOTFILES_DIR/fish_functions/* ~/.config/fish/functions

# tmux
> ln -s $DOTFILES_DIR/.tmux.conf ~/.tmux.conf

# vi-like
> ln -s $DOTFILES_DIR/.vimrc ~/.vimrc
> ln -s $DOTFILES_DIR/.ideavimrc ~/.ideavimrc
> ln -s $DOTFILES_DIR/nvim ~/.config/nvim

# lsd
> ln -s $DOTFILES_DIR/lsd/config.yaml ~/.config/lsd/config.yaml
> ln -s $DOTFILES_DIR/lsd/dracula.yaml ~/.config/lsd/themes/dracula.yaml

# procs
> ln -s $DOTFILES_DIR/.procs.toml ~/.procs.toml
```
