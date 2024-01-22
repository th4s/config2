# Return if not interactive
if ! status is-interactive
    return
end

# Set color scheme
fish_set_colors

# Do not abbreviate directories
set -g fish_prompt_pwd_dir_length 0

# Disable greeting
set -g fish_greeting

# Set up ssh agent
eval (ssh-agent -c) > /dev/null
set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
set -Ux SSH_AGENT_PID $SSH_AGENT_PID

# Set editor 
if test -n (command -q nvim)
    set -gx EDITOR "/usr/bin/nvim"
    alias n nvim
end

# Set visual and editor variables
set -gx VISUAL $EDITOR

# Set some rust aliases
if test -n (command -q cargo)
    # Some useful aliases
    alias rsup "rustup update && cargo install-update --all"
    alias c cargo
    alias cc "c c"
    alias ct "c t"
end

if test -n (command -q xdg-open)
    alias open xdg-open
    alias o open
end

# Some useful everyday aliases
alias ... "cd ../.."
alias .... "cd ../../.."
alias ss "source "$HOME"/.config/fish/config.fish"

# Git
if test -n (command -q git)
    alias gs "git status -sb"
    alias ga "git add -A"
    alias gd "git diff HEAD"
    alias gl "git log"
end

