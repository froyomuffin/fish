function goto
    set LOC $argv[1]
    count $LOC > /dev/null ;and test -d $LOC ;and set -U GOTO $LOC
    test -d $GOTO ;and cd $GOTO
end

