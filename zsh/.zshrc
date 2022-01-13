# ------------------------------------------------------------------------------
# Custom prompt engine
# ------------------------------------------------------------------------------
# Load oh-my-posh
eval "$(oh-my-posh --init --shell zsh --config ~/.config/ohmyposh/themes/dracula.omp.json)"

# Load strarship
# export STARSHIP_CONFIG=$HOME/.config/starship/themes/dracula.toml
# eval "$(starship init zsh)"

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------
alias ga='git add'

# History
HISTSIZE=1000
SAVEHIST=1000
# HISTFILE=~/.cache/zsh/history
HISTFILE=~/.config/zsh/.histfile

autoload -U compinit && compinit -u
# Show selection highlight
zstyle ':completion:*' menu select
zstyle ':completion:*:*:cd:*' menu yes select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload -i zsh/complist
# Include hidden files
_comp_options+=(globdots)

# ------------------------------------------------------------------------------
# Vi mode
# ------------------------------------------------------------------------------
# Activate vim mode.
bindkey -v
# Remove mode switching delay.
export KEYTIMEOUT=1

bindkey '^R' history-incremental-pattern-search-backward

# Use vim keys in tab complete menu:
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'right' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char

bindkey -M menuselect 'K' beginning-of-history
bindkey -M menuselect 'J' end-of-history
bindkey -M menuselect 'H' vi-beginning-of-line
bindkey -M menuselect 'L' vi-end-of-line


# Navigate throug history with n/p keys
bindkey -M viins '^n' vi-down-line-or-history
bindkey -M viins '^p' vi-up-line-or-history
bindkey -M vicmd '^n' vi-down-line-or-history
bindkey -M vicmd '^p' vi-up-line-or-history

# Accept selection
bindkey -M menuselect '^y' accept-line

# Cancel selection
bindkey -M menuselect '^e' send-break
bindkey -M menuselect '\e' send-break

# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

# ------------------------------------------------------------------------------
# Cursor shapes
# Source: https://unix.stackexchange.com/q/433273
#
# https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Functions-using-CSI-_-ordered-by-the-final-character_s_
# Ps = 0  ⇒  blinking block.
# Ps = 1  ⇒  blinking block.
# Ps = 2  ⇒  steady block.
# Ps = 3  ⇒  blinking underline.
# Ps = 4  ⇒  steady underline.
# Ps = 5  ⇒  blinking bar.
# Ps = 6  ⇒  steady bar.
# ------------------------------------------------------------------------------

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

_fix_cursor() {
   echo -ne '\e[5 q'
}

# Use beam shape cursor on startup and for each new prompt.
precmd_functions+=(_fix_cursor)
