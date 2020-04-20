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

function reset_colors
  set -Ux fish_color_autosuggestion 555\x1ebrblack
  set -Ux fish_color_cancel \x2dr
  set -Ux fish_color_command \x2d\x2dbold
  set -Ux fish_color_comment red
  set -Ux fish_color_cwd green
  set -Ux fish_color_cwd_root red
  set -Ux fish_color_end brmagenta
  set -Ux fish_color_error brred
  set -Ux fish_color_escape bryellow\x1e\x2d\x2dbold
  set -Ux fish_color_history_current \x2d\x2dbold
  set -Ux fish_color_host normal
  set -Ux fish_color_match \x2d\x2dbackground\x3dbrblue
  set -Ux fish_color_normal normal
  set -Ux fish_color_operator bryellow
  set -Ux fish_color_param cyan
  set -Ux fish_color_quote yellow
  set -Ux fish_color_redirection brblue
  set -Ux fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
  set -Ux fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
  set -Ux fish_color_user brgreen
  set -Ux fish_color_valid_path \x2d\x2dunderline
  set -Ux fish_pager_color_completion \x1d
  set -Ux fish_pager_color_description B3A06D\x1eyellow
  set -Ux fish_pager_color_prefix white\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
  set -Ux fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan
  set -Ux fish_user_paths /usr/local/opt/fzf/bin
  set -Ux fisher_active_prompt default
  set -Ux fisher_dependency_count getopts\x1ez\x1evcs\x1edefault
end

function goto
  set LOC $argv[1]
  count $LOC > /dev/null ;and test -d $LOC ;and set -U GOTO $LOC
  test -d $GOTO ;and cd $GOTO
end

function set-goto
  echo "Setting goto directory to '$PWD'"
  goto $PWD
end

alias here=set-goto
alias home=set-goto

set LOCKFILE ~/.config/.goto_lock

function lock
  set-goto

  touch $LOCKFILE
  echo "Locked default directory to '$GOTO'"
end

function unlock
  if test -e $LOCKFILE
    rm $LOCKFILE
  end
  echo "Unlocked default directory ($PWD)"
end

function handle-default-location
  if test -e $LOCKFILE
    goto
  end
end

# Load private fish
safe-source ~/.private.fish

# Disable welcome message
set fish_greeting ""

# Vi!
#fish_vi_key_bindings
fish_default_key_bindings

# Avoid duplicates in history
set -g hist_ignore_dups

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

# fd
function-exists fd ;and alias find 'fd'

# ~/bin
add-to-path ~/bin

# Cargo
add-to-path ~/.cargo/bin

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

# Reload default colors
reset_colors
