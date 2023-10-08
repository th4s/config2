if test -n (command -q tmux) && status is-interactive && ! status is-login && test isatty && not set -q TMUX
    exec tmux
end
