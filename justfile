set shell := ["fish", "-c"]
set script-interpreter := ["fish"]
set unstable

plugin := "havok.screen"

[script]
defualt:
    omarchy restart shell &> /dev/null
    omarchy plugin enable {{ plugin }} &> /dev/null
    omarchy-shell shell summon havok.screen &> /dev/null
    qs log -p "$OMARCHY_PATH/shell" -f
