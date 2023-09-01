# local variables
set -l os (uname)

# local functions
function alias_if_exists
  if type -q $argv[1]
    alias $argv[2]=$argv[3]
  end
end

function fish_add_path_if_exists
  if test -e $argv[1]
    fish_add_path $argv[1]
  end
end

# editors
alias_if_exists nvim 'v' 'nvim'
alias_if_exists nvim 'vi' 'nvim'
alias_if_exists nvim 'vim' 'nvim'

# configs
alias zshconf='v ~/.zshrc'
alias gitconf='v ~/.gitconfig'
alias vimconf='v ~/.vimrc'
alias nvimconf='v ~/.config/nvim/init.vim'
alias tmuxconf='v ~/.tmux.conf'
alias alacrittyconf='v ~/.alacritty.yml'
alias fishconf='v ~/.config/fish/config.fish'

# coreutils alternatives
alias_if_exists lsd 'ls' 'lsd'
alias_if_exists lsd 'tree' 'lsd --tree'
alias_if_exists bat 'cat' 'bat'
alias_if_exists fd 'find' 'fd'
alias_if_exists procs 'ps' 'procs'
alias_if_exists rg 'grep' 'rg'
alias_if_exists delta 'diff' 'delta'

# node
if type -q nvm && type -q node
  fish_add_path ~/.nvm/versions/node/(node -v)/bin
end

# npm
if type -q npm
  alias ni='npm install'
  alias ns='npm start'
  alias nt='npm test'
  alias nr='npm run'
  alias nls='npm list --depth 0'
end

# pnpm
if type -q pnpm
  alias pni='pnpm install'
  alias pns='pnpm start'
  alias pnt='pnpm test'

  if test $os = Darwin
    set -gx PNPM_HOME "~/Library/pnpm"
    fish_add_path $PNPM_HOME
  end
end

# gradle
alias gd='./gradlew'

# cargo
if type -q cargo
  alias cb='cargo build'
  alias cr='cargo run'
  alias ck='cargo check'
  alias cl='cargo fmt && cargo clippy'
  alias rs='cargo script'
end

# python
if type -q pyenv
  set -gx PYENV_ROOT ~/.pyenv
  fish_add_path_if_exists $PYENV_ROOT/bin
  pyenv init - | source
end
alias_if_exists python 'py' 'python'

# docker
if type -q docker
  alias dk='docker'
  alias dkp='docker ps'
  alias dkk='docker stop (docker ps -q)'
  alias dki='docker inspect --format="{{.Id}}"'
  alias dks='docker start'
end

# tmux
if type -q tmux
  alias tx='tmux'
  alias txn='tmux new -s'
  alias txl='tmux choose-tree'
  alias txk='tmux kill-session -t'
  alias txka='tmux kill-session -a'
  fish_add_path_if_exists ~/.tmux/plugins/tpm
end

# fzf
if type -q fzf
  alias fh='history | fzf'
end

# tectonic
if type -q tex
  alias texn='tex new pure'
  alias texb='tex build'
  alias texw='tex watch'
  alias texo='tex open'
end

# others
alias clr='clear'
alias please='sudo'
alias mv='mv -i'
alias monitor='top -o vsize'
alias_if_exists git 'g' 'git'
alias_if_exists trash 'rm' 'trash'
alias_if_exists mycli 'sql' 'mycli'
alias_if_exists z 'j' 'z'
alias_if_exists imgcat 'img' 'imgcat'
alias_if_exists npx 'ts' 'npx tsx'
alias_if_exists npx 'marp' 'npx @marp-team/marp-cli@latest'

# universal fish user paths for binaries
if test $os = Darwin
  fish_add_path_if_exists /opt/homebrew/bin
  fish_add_path_if_exists /opt/homebrew/opt/libpq/bin
end
fish_add_path_if_exists /opt/local/bin
fish_add_path_if_exists ~/.deno/bin
fish_add_path_if_exists ~/.cargo/bin
fish_add_path_if_exists ~/.cabal/bin
fish_add_path_if_exists ~/.ghcup/bin
fish_add_path_if_exists ~/bin
# to erase one: `fish_user_path erase`

# env variables
if type -q bat; set -gx BAT_THEME Dracula; end
if type -q nvim; set -gx EDITOR nvim; end
if test -e ~/projects; set -gx PROJECT_DIR ~/projects; end
if test -e ~/projects; set -gx TEX_PREAMBLES_DIR ~/Documents/TeX/preambles; end

# theme
fish_config theme choose "Dracula Official"
