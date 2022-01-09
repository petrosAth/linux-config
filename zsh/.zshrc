# ------------------------------------------------------------------------------
## Add the following to ~/<user>/.zshenv
## Path to your zsh dot files
# export ZDOTDIR="$HOME/.config/zsh"
# ------------------------------------------------------------------------------

# Custom prompt engine #--------------------------------------------------------
# Load oh-my-posh and set a theme
eval "$(oh-my-posh --init --shell zsh --config ~/.config/ohmyposh/themes/dracula.omp.json)"

# Load strarship
# export STARSHIP_CONFIG=$HOME/.config/starship/themes/dracula.toml
# eval "$(starship init zsh)"
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------
alias ga='git add'

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

# ------------------------------------------------------------------------------
# Vim mode config
# Source: https://unix.stackexchange.com/q/433273
#
# Cursor shapes
# https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Functions-using-CSI-_-ordered-by-the-final-character_s_
# Ps = 0  ⇒  blinking block.
# Ps = 1  ⇒  blinking block.
# Ps = 2  ⇒  steady block.
# Ps = 3  ⇒  blinking underline.
# Ps = 4  ⇒  steady underline.
# Ps = 5  ⇒  blinking bar.
# Ps = 6  ⇒  steady bar.
# ------------------------------------------------------------------------------

# Activate vim mode.
bindkey -v

# Remove mode switching delay.
KEYTIMEOUT=5

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
