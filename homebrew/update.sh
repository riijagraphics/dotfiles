#!/usr/bin/env bash
#
# Homebrew
#
# This updates Homebrew and it's formulaes.

source $DOTFILES/scripts/utils.sh

if [[ $(which brew) ]]; then
    e_update "Homebrew"
    # reset permissions for node
    sudo chown -R $(whoami) /usr/local
    (brew update) > /dev/null 2>&1
    e_success

    e_update "Homebrew formulaes"
    (brew upgrade --all && brew cleanup) > /dev/null 2>&1
    e_success
fi

exit 0
