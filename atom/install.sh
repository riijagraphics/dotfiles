#!/usr/bin/env bash
#
# Atom
#
# Installs useful Atom packages.
#

source $DOTFILES/scripts/utils.sh

# Check if NPM is installed
if [ $(which apm) ]; then
  e_header "Installing atom packages"

  apm install autocomplete-php color-picker docblockr emmet jshint minimap react travis-ci-status pigments merge-conflicts atom-beautify

  e_success "Packages installed successfully"
fi

exit 0
