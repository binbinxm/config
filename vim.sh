#!/bin/sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp vim/vimrc ~/.vimrc
mkdir -p ~/.vim/colors
cp vim/solarized.vim ~/.vim/colors/
