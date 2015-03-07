#!/bin/bash

# Install dotfiles and fonts.

# Usage: setup.sh [--force|--fonts]
#   --force    Remove dotfiles without asking.
#   --fonts    [Re]install fonts.

set -e

function install_fonts() {
    WORK_DIR=/tmp/fonts
    ADOBE_URL=https://github.com/adobe-fonts/source-code-pro/archive/1.017R.zip
    HERMIT_URL=https://pcaro.es/d/otf-hermit-1.21.tar.gz

    # Initializing directories.
    mkdir -p ~/.fonts
    mkdir -p $WORK_DIR/hermit

    # Getting the adobe fonts.
    wget $ADOBE_URL -O $WORK_DIR/source-code-pro.zip
    unzip $WORK_DIR/source-code-pro.zip -d $WORK_DIR
    cp $WORK_DIR/source-code-pro-*/OTF/*.otf ~/.fonts

    # Getting hermit fonts.
    wget $HERMIT_URL -O $WORK_DIR/hermit.tar.gz
    tar xzvf $WORK_DIR/hermit.tar.gz -C $WORK_DIR/hermit
    cp $WORK_DIR/hermit/*.otf ~/.fonts

    # Updating font cache.
    fc-cache -f -v

    # Removing directories.
    rm -rf $WORK_DIR
}

if [[ ! -e ~/.fonts ]] || [[ $1 == "--fonts" ]]; then
    install_fonts
fi

# Current directory of this script.
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Creating symbolic links.
for file in $DOTFILES_DIR/*; do
    file=$(basename $file)

    # Ignore setup.sh, scripts and INSTALL
    if [[ $file == "setup.sh" ]] || [[ $file == "scripts" ]] || [[ $file == "INSTALL" ]]; then
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
