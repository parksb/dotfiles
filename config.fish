# local variables
set -l OS (uname)

# editors
alias ij='idea'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# configs
alias zshconf='v ~/.zshrc'
alias gitconf='v ~/.gitconfig'
alias vimconf='v ~/.vimrc'
alias nvimconf='v ~/.config/nvim/init.vim'
alias tmuxconf='v ~/.tmux.conf'
alias alacrittyconf='v ~/.alacritty.yml'
alias fishconf='v ~/.config/fish/config.fish'

# coreutils alternatives
alias ls='lsd'
alias tree='lsd --tree'
alias cat='bat'
alias find='fd'
alias ps='procs'
alias grep='rg'
alias diff='delta'

# node
fish_add_path ~/.nvm/versions/node/(node -v)/bin

# npm
alias ni='npm install'
alias ns='npm start'
alias nt='npm test'
alias nr='npm run'
alias nls='npm list --depth 0'

# pnpm
alias pni='pnpm install'
alias pns='pnpm start'
alias pnt='pnpm test'
if test "$OS" = Darwin
  set -gx PNPM_HOME "~/Library/pnpm"
  fish_add_path $PNPM_HOME
end

# gradle
alias gd='./gradlew'

# cargo
alias cb='cargo build'
alias cr='cargo run'
alias ck='cargo check'
alias cl='cargo fmt && cargo clippy'
alias rs='cargo script'

# python
alias py='python'
set -gx PYENV_ROOT ~/.pyenv
fish_add_path $PYENV_ROOT/bin
pyenv init - | source

# docker
alias dk='docker'
alias dkp='docker ps'
alias dkk='docker stop (docker ps -q)'
alias dki='docker inspect --format="{{.Id}}"'
alias dks='docker start'

# tmux
alias tx='tmux'
alias txn='tmux new -s'
alias txl='tmux choose-tree'
alias txk='tmux kill-session -t'
alias txka='tmux kill-session -a'
fish_add_path ~/.tmux/plugins/tpm

# fzf
alias fh='history | fzf'

# tectonic
alias texn='tex new pure'
alias texb='tex build'
alias texw='tex watch'
alias texo='tex open'

# others
alias rm='trash'
alias mv='mv -i'
alias clr='clear'
alias g='git'
alias ts='ts-node'
alias please='sudo'
alias az5='docker stop (docker ps -q) and pm2 kill and tmux kill-session -a and tmux ls'
alias monitor='top -o vsize'
alias sql='mycli'
alias j='z'
alias img='imgcat'
alias marp='npx @marp-team/marp-cli@latest'

# universal fish user paths for binaries
if test "$OS" = Darwin
  fish_add_path /opt/homebrew/bin
  fish_add_path /opt/homebrew/opt/libpq/bin
end
fish_add_path /opt/local/bin
fish_add_path ~/.deno/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.cabal/bin
fish_add_path ~/.ghcup/bin
fish_add_path ~/bin
# to erase one: `$ fish_user_path erase`

# env variables
set -gx BAT_THEME Dracula
set -gx EDITOR nvim
set -gx PROJECT_DIR ~/projects
set -gx TEX_PREAMBLES_DIR ~/Documents/TeX/preambles

# theme
fish_config theme choose "Dracula Official"
