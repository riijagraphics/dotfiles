#!/usr/bin/env bash
#
# Atom
#
# This updates all atom packages.

source $DOTFILES/scripts/utils.sh

if [ $(which apm) ]; then
    e_header "Updating atom packages"

    apm upgrade --confirm=false

    e_success "Packages updated successfully"
fi

exit 0
