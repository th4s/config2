# Return if not interactive
if ! status is-interactive
    return
end

# A better ls alternative
if test -n (command -q eza)
    alias ls "eza --icons"
    alias ll "eza -algF --icons"

    function tree --description "Shows directory content in a tree"
        if test (count $argv) -eq 0
            eza -lgF --tree --git-ignore --icons
        else
            eza -lgF --tree --git-ignore --icons -L $argv[1]
        end
    end
end

# Copy whole file, or lines A:B from a file to clipboard
if test -n (command -q bat) && test -n (command -q xclip) 
    function lc --description "Copy content of a file to clipboard" 
        if test (count $argv) -eq 1
            bat -pp $argv[1] | xclip -se c
        else
            bat -pp -r $argv[1] $argv[2] | xclip -se c
        end
    end
end

# VPN
if test -n (command -q wg) && test -n (command -q wg-quick)
    function vpn --description "Connect to a VPN"
        if test $argv[1] = "u"
            wg-quick up $argv[2]
            if test -f "$HOME/._proxyconf.pac" 
                mv "$HOME/._proxyconf.pac" "$HOME/.proxyconf.pac"
            end
        else if test $argv[1] = "d"
            set -l current $(sudo wg show | awk 'FNR == 1 { print $2}')
            if test -n "$current"
                wg-quick down $current;
            end
            if test -f "$HOME/.proxyconf.pac"
                mv "$HOME/.proxyconf.pac" "$HOME/._proxyconf.pac"
            end
        else
            echo "Usage: vpn [u|d] [interface]"
        end
    end
end

# Calculator
function calc --description "A simple calculator"
    # Set comma to decimal point on German keyboard
    xmodmap -e "keycode 91 mod2 = KP_Delete period"; bc -ql; xmodmap -e "keycode 91 mod2 = KP_Delete comma"
end

# Configure xclip
if test -n (command -q xclip)
    # copy to clipboard
    alias xc "xclip -se c"
    # copy to pirmary buffer
    alias xb "xclip"
end

# Switch wifi network
function switch-net --description "Switch wifi network"
    wpa_cli list_networks
    read -l -n 1 -P "Please select a network: " network
    wpa_cli select_network $network
end

# Some more useful functions
function where --description "Recursively search for a file"
    find . -iname "*$argv[1]*"
end

function weather --description "Get the weather"
    curl wttr.in/$argv[1]
end

function random-pk --description "Generate a random private key for Ethereum"
    cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 64 | head -n $argv[1]
end

