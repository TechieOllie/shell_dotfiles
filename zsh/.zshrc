#!/usr/bin/env zsh

# Add to PATH
export PATH="/home/ol/flutter/bin:$PATH"

# Lazy-load antidote and generate the static load file only when needed
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source ~/.antidote/antidote.zsh
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi
source ${zsh_plugins}.zsh

# Load ssh agent
eval "$(ssh-agent -s)" > /dev/null
# ssh-add ~/.ssh/id_ed25519 2>/dev/null


# Load aliases
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

#Load Starship prompt
eval "$(starship init zsh)"
