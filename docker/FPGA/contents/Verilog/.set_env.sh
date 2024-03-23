#!/bin/bash

mkdir ~/.vim/colors
mv ./.env/grivbox/gruvbox.vim ~/.vim/colors

echo "colorscheme gruvbox" >> ~/.vimrc
echo "set background=dark" >> ~/.vimrc

source ~/.vimrc
