#!/bin/bash

DOTFILES_DIR=$( cd $(dirname $0) ; pwd -P )


files_to_link=(
  ".gitconfig"
  ".git-completion.bash"
  ".git-prompt.sh"
  ".inputrc"
  ".bashrc"
  ".bash_profile"
  ".bash_logout"
);


if [[ $1 != "--overwrite" ]]; then
  echo "WARNING: This script will overwrite existing files or links in your home dir."
  echo "         Consider backing them up and re-run the script with the --overwrite argument."
  echo ""
  echo "Affected paths:"
  for file_name in ${files_to_link[@]}; do
    echo "~/$file_name"
  done
else
  for file_name in ${files_to_link[@]}; do
    # soft, verbose, force
    ln -svf $DOTFILES_DIR/$file_name ~
  done
fi
