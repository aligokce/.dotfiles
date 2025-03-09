#!/bin/bash

# Ensuring the script works regardless of where it's called from
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

BACKUP_DIR="$HOME/.dotfiles/backup/$(date +%Y%m%d_%H%M%S)"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to backup and symlink files
link_file() {
    local src="$1"
    local dst="$2"

    # Backup existing file if it exists and is not a symlink to our file
    if [ -e "$dst" ] && [ ! -L "$dst" -o "$(readlink "$dst")" != "$src" ]; then
        echo "Backing up $dst to $BACKUP_DIR/"
        mv "$dst" "$BACKUP_DIR/"
    fi

    # Create symlink
    if [ ! -e "$dst" ]; then
        echo "Creating symlink for $src to $dst"
        ln -s "$src" "$dst"
    fi
}

# Symlink dotfiles
link_file "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
link_file "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"
link_file "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.hushlogin" "$HOME/.hushlogin"
link_file "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

