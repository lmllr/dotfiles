#!/bin/bash

original=(.zshrc .zsh_aliases .gitignore_global .tmux.conf .tmux.powerline.conf .hushlogin)

# Just elements.
for element in "${original[@]}"; do
    `ln $HOME/$element $element`
done
