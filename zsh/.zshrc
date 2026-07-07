#!/usr/bin/env zsh
# Add path
# source ${ZDOTDIR:-$HOME}/.zsh_path
[ -f ~/.zsh_path ] && source ~/.zsh_path

# Set QT theme
export QT_QPA_PLATFORMTHEME=qt6ct

# SSH agent via gcr (gnome-keyring integration, auto-unlocked at login)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"

# Lazy-load antidote and generate the static load file only when needed
#zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
#if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
#  (
#    source ~/.antidote/antidote.zsh
#    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
#  )
#fi
#source ${zsh_plugins}.zsh

# Load antidote
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh

antidote load

eval "$(register-python-argcomplete pipx)"

# Load aliases
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
[ -f ~/.zsh_aliases_wsl ] && source ~/.zsh_aliases_wsl

#Load Starship prompt
eval "$(starship init zsh)"


[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
