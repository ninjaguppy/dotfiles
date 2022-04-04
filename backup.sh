#!/usr/bin/env bash

# check to see is git command line installed in this machine
IS_GIT_AVAILABLE="$(git --version)"
if [[ $IS_GIT_AVAILABLE == *"version"* ]]; then
  echo "Git is Available"
else
  echo "Git is not installed"
  exit 1
fi


# copy other dot files
cp  $HOME/{.zshrc,.vimrc} .
cp -r $HOME/.config/alacritty/ ./.config/alacritty/
cp -r $HOME/.config/karabiner/ ./.config/karabiner/
cp -r $HOME/.config/sketchybar/ ./.config/sketchybar/
cp -r $HOME/.config/skhd/ ./.config/skhd/
cp -r $HOME/.config/yabai/ ./.config/yabai/
cp -r $HOME/.doom.d/ ./.doom.d/



# Check git status
gs="$(git status | grep -i "modified")"
# echo "${gs}"

# If there is a new change
if [[ $gs == *"modified"* ]]; then
  echo "push"
fi


# push to Github
git add -u;
git commit -m "New backup `date +'%Y-%m-%d %H:%M:%S'`";
git push origin master
