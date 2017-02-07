set -x PATH ~/bin/ ~/git/toolbox/bin/ $PATH
set -x EDITOR nvim

function check-cmd
    which $argv[1]
    return $status
end

# Vi!
fish_vi_key_bindings

# Linux applications
check-cmd pulseaudio ;and test -z (pidof pulseaudio) ;and echo 'Starting pulseaudio' ;and pulseaudio --start
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
check-cmd nvim ;and alias vim='nvim'

source ~/.private.fish
