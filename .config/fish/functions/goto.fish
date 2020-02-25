function goto
  set LOC $argv[1]
  count $LOC > /dev/null ;and test -d $LOC ;and set -U GOTO $LOC
  test -d $GOTO ;and cd $GOTO
end

set LOCKFILE ~/.config/.goto_lock

function lock
  if test -e $LOCKFILE
    rm $LOCKFILE
  else
    touch $LOCKFILE
  end
end

function handle_default_location
  if test -e $LOCKFILE
    goto
  end
end
