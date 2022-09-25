#!/usr/bin/env zsh

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################

export DOTFILES="$HOME/.dotfiles"
export WORKSPACE="$HOME/workspace"

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$HOME/.histfile"    # History filepath
export HISTSIZE=10000                               # Maximum events for internal history
export SAVEHIST=10000                               # Maximum events in history file

export VIMCONFIG="$XDG_CONFIG_HOME/nvim"
export SCREENSHOT="$HOME/Documents/images/screenshots"

# Man pages
export MANPAGER='nvim +Man!'

skip_global_compinit=1
. "$HOME/.cargo/env"
