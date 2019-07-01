#!/bin/sh
apt-get install tmux -y
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
echo "set-option -g default-shell /bin/zsh" >> ~/.tmux.conf
