#!/bin/bash

# Install dotfiles and fonts.

# Usage: setup.sh [--force]
#   --force    Remove dotfiles without asking.

set -e

function install_fonts() {
    WORK_DIR=/tmp/adobefont
    URL=https://github.com/adobe-fonts/source-code-pro/archive/1.017R.zip

    # Initializing directories.
    mkdir -p ~/.fonts
    mkdir -p $WORK_DIR

    # Getting the fonts.
    wget $URL -O $WORK_DIR/source-code-pro.zip
    unzip $WORK_DIR/source-code-pro.zip -d $WORK_DIR
    cp $WORK_DIR/source-code-pro-*/OTF/*.otf ~/.fonts/

    # Updating font cache.
    fc-cache -f -v

    # Removing directories.
    rm -rf $WORK_DIR
}

if [[ ! -e ~/.fonts/SourceCodePro-Medium.otf ]]; then
    install_fonts
fi

# Current directory of this script.
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Creating symbolic links.
for file in $DOTFILES_DIR/*; do
    file=$(basename $file)

    # Ignore setup.sh
    if [[ $file == "setup.sh" ]]; then
        continue;
    fi

    # If the file exist, prompt for user input.
    if [[ -e ~/.$file ]] && [[ $1 != "--force" ]]; then
        echo -n ".$file exist, do you want to delete it? [y/N] "
        read -n 1 answer

        [ ${#answer} -eq 1 ] && echo

        if [[ $answer =~ ^([yY])$ ]]; then
            # The file may be a directory.
            rm -rf ~/.$file
        else
            continue
        fi
    elif [[ $1 == "--force" ]]; then
	# The file may be a directory.
	rm -rf ~/.$file
    fi

    # Create the symbolic link.
    ln -s $DOTFILES_DIR/$file ~/.$file
done
