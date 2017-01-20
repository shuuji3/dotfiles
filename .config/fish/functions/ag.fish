function ag
    # Set match text color to bold & red(1;31)
    command ag --color-match '1;31' $argv
end
