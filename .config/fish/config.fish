set -x PATH ~/bin/ /git/toolbox/bin/ $PATH

function check-cmd
    which $argv[1]
    return $status
end

# Linux applications
check-cmd pulseaudio ;and test -z (pidof pulseaudio) ;and echo 'Starting pulseaudio' ;and pulseaudio --start
check-cmd startx ;and test -z $DISPLAY ;and test $XDG_VTNR -eq 1 ;and exec startx
check-cmd xdg-open ;and alias open='xdg-open'

# Set clipboard to c and v
check-cmd xclip ;and alias c='xclip -selection clipboard' ;and alias v='xclip -o -selection clipboard'
check-cmd pbcopy ;and alias c='pbcopy'; check-cmd pbpaste ;and alias v='pbpaste'

# Fix ctags in macOS
check-cmd brew ;and alias ctags=(brew --prefix ctags)'/bin/ctags'

# Neovim
check-cmd nvim ;and alias vim='nvim'

source ~/.private.fish
