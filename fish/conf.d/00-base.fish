# Return if not interactive or login shell 
if ! status is-interactive || status is-login
    return
end

# Set CAPSLOCK as an additional CTRL
setxkbmap -option caps:ctrl_modifier,shift:both_capslock

# Set color scheme
fish_set_colors

# Disable greeting
set -U fish_greeting

# GPG Settings
set -Ux GPG_TTY (tty)

# Set editor 
if test -n "$(command -v nvim)"
    set -Ux EDITOR "/usr/bin/nvim"
    alias n nvim
end

# Set visual and editor variables
set -Ux VISUAL $EDITOR

# Set some rust aliases
if test -n "$(command -v cargo)"
    # Some useful aliases
    alias c cargo
    alias cc "c c"
    alias ct "c t"
end

if test -n "$(command -v xdg-open)"
    alias open xdg-open
    alias o open
end

# Some useful everyday aliases
alias ... "cd ../.."
alias .... "cd ../../.."
alias ss "source "$HOME"/.config/fish/config.fish"

# Git
if test -n "$(command -v git)"
    alias gs "git status -sb"
    alias ga "git add -A"
    alias gd "git diff HEAD"
    alias gl "git log"
end

