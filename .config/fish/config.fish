set -x PATH ~/bin/ ~/git/toolbox/bin/ ~/.gem/ruby/2.4.0/bin $PATH

function check-cmd
    which $argv[1] /dev/null 2> /dev/null
    return $status
end

# Vi!
#fish_vi_key_bindings
fish_default_key_bindings

# Avoid duplicates in history

# Linux applications
#check-cmd pulseaudio ;and test -z (pidof pulseaudio) ;and echo 'Starting pulseaudio' ;and pulseaudio --start
check-cmd startx ;and test -z $DISPLAY ;and test $XDG_VTNR -eq 1 ;and exec startx
check-cmd xdg-open ;and alias open='xdg-open'

# Set clipboard to c and v
check-cmd xclip ;and alias c='xclip -selection clipboard' ;and alias v='xclip -o -selection clipboard'
check-cmd pbcopy ;and alias c='pbcopy'; check-cmd pbpaste ;and alias v='pbpaste'

# Fix ctags in macOS
check-cmd brew ;and check-cmd ctags ;and alias ctags=(brew --prefix ctags)'/bin/ctags'

# Default tag
check-cmd ctags ;and alias tag='ctags -R'

# Neovim
set -x EDITOR nvim
check-cmd nvim ;and alias vim='nvim'

source ~/.private.fish
#status --is-login; and status --is-interactive; and exec byobu-launcher

# Bindings break for some reason... Temporary fix
fzf_key_bindings
