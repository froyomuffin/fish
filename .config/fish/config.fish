function invert
  if [ $argv[1] = 0 ]
    return 1
  else
    return 0
  end
end

function function-exists
  which $argv[1] > /dev/null 2> /dev/null
  return $status
end

function dir-exists
  test -d $argv[1]
  return $status
end

function file-exists
  test -e $argv[1]
  return $status
end

function add-to-path
  dir-exists $argv[1] ;and set -x PATH $argv[1] $PATH
end

function safe-source
  file-exists $argv[1] ;and . $argv[1]
end

function is-running
  pgrep -f $argv[1] > /dev/null
end

function in-tmux
  test -n "$TMUX"
end

function in-ssh-session
  test -n "$SSH_CLIENT"
end

function set-upstream
  set -l branch_name (git rev-parse --abbrev-ref HEAD)
  git push --set-upstream origin $branch_name
end

# Load private fish
safe-source ~/.private.fish

# Disable welcome message
set fish_greeting ""

# Vi!
#fish_vi_key_bindings
fish_default_key_bindings

# Avoid duplicates in history
#set -g hist_ignore_dups

# Linux applications
function-exists startx ;and [ $DISPLAY ] ;and test -z $DISPLAY ;and test $XDG_VTNR -eq 1 ;and exec startx
function-exists xdg-open ;and alias open 'xdg-open'

# Set clipboard to c and v
function-exists xclip ;and alias c 'xclip -selection clipboard' ;and alias v 'xclip -o -selection clipboard'
function-exists pbcopy ;and alias c 'pbcopy'; function-exists pbpaste ;and alias v 'pbpaste'

# Default tag
function-exists ctags ;and alias tag 'ctags -R'

# Neovim
set -x EDITOR nvim
function-exists nvim ;and alias vim 'nvim'

# Exa
function-exists exa ;and alias ls 'exa'

# ~/bin
add-to-path ~/bin

# fd
function-exists fd ;and alias find 'fd'

# FZF File Search with Rg
function-exists rg ;and set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --smart-case --no-ignore --glob "!.git/*"'

# Bindings break for some reason... Temporary fix
fzf_key_bindings

# Share history between shells
function sync_history --on-event fish_preexec
  history --save
  history --merge
end

if test -f /opt/dev/dev.fish
  source /opt/dev/dev.fish
end
