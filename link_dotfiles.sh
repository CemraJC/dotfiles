#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc bash_profile gitconfig minttyrc npmrc vimrc wgetrc ssh/config"

##########

# Make backups
printf "%s %s" "Creating backups in" $olddir
mkdir -p $olddir
for file in $files; do
    mv ~/.$file ~/dotfiles_old/ > /dev/null
done
printf " ...done\n"

# Make the symlinks
printf "%s %s" "Moving into" $dir
cd $dir
printf " ...done\n"

for file in $files; do
    printf "%s %s" "Creating symlink for" $file
    ln -s $dir/.$file ~/.$file
    printf " ...done\n"
done

printf "Symlinking Complete!"