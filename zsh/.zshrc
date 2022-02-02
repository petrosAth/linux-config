# Fix auto-complete messing prompt
export LANG=en_US.UTF-8

# ------------------------------------------------------------------------------
# Theme
# ------------------------------------------------------------------------------
zsh_colorscheme="nord" # Alacritty color theme must also be changed
zsh_prompt="ohmyposh"

# Custom prompt engine ---------------------------------------------------------
case ${zsh_prompt} in
    ohmyposh)
        # Load oh-my-posh
        eval "$(oh-my-posh --init --shell zsh --config $HOME/dotfiles/ohmyposh/themes/${zsh_colorscheme}.omp.json)" ;;
    starship)
        # Load strarship
        export STARSHIP_CONFIG=$HOME/dotfiles/starship/themes/dracula.toml
        eval "$(starship init zsh)" ;;
esac
# ------------------------------------------------------------------------------

# Custom dircolors -------------------------------------------------------------
# Load colorscheme
eval "$(dircolors ~/dotfiles/zsh/colorschemes/dircolors/${zsh_colorscheme}.dircolors)"
# Make ls results, colored
alias ls='ls --color=auto'
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# History
# ------------------------------------------------------------------------------
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=${HOME}/.zsh_history

# ------------------------------------------------------------------------------
# Autosuggest
# ------------------------------------------------------------------------------
# source "zsh_autosuggestions.zsh" file
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# set autosuggestion colorscheme automatically from variable
case ${zsh_colorscheme} in
    nord)
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#4c566a,bold" ;;
    dracula)
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6272A4,bold" ;;
esac

# Specify how suggestions should be generated
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

# ------------------------------------------------------------------------------
# Autocomplete
# ------------------------------------------------------------------------------
autoload -U compinit && compinit -u
# Show selection highlight
zstyle ':completion:*' menu yes select
# zstyle ':completion:*:*:cd:*' menu yes select
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
bindkey -M viins '^y' .accept-line

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

# Cursor shapes ----------------------------------------------------------------
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

# Change cursor shape for different vi modes -----------------------------------
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
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------
alias ga='git add'

# ------------------------------------------------------------------------------
# Syntax highlighting
# ------------------------------------------------------------------------------
# Highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp cursor root line)
# Plugin location
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
