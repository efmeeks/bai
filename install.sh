#!/bin/bash

# Better Apt Installer
# https://git.io/vdimV

# Installer for bai

checkdeps(){
  [ -z $(which apt) ] && echo "apt is missing" && exit
  [ -z $(which apt-get) ] && echo "apt-get is missing" && exit
}

setprofile(){
  while [ -z $PROFILE ]; do
    [ -e ~/.bashrc ] && PROFILE="${HOME}/.bashrc" && break
    [ -e ~/.profile ] && PROFILE="${HOME}/.profile" && break
    [ -e ~/.bash_profile ] && PROFILE="${HOME}/.bash_profile" && break
    [ -e /etc/profile ] && PROFILE="/etc/profile" && break
    PROFILE="${HOME}/.bashrc"
  done
}

setpath() {
  if [[ -z $(echo $PATH | tr ':' '\n' | egrep "${HOME}/bin[/]?") ]]; then
    if [[ -z $(cat $PROFILE | egrep '[export ]?PATH="\${HOME}/bin:\$PATH"') ]]; then
      echo 'export PATH="${HOME}/bin:$PATH"' >> $PROFILE
    else
      source $PROFILE
    fi
  else
    echo '$HOME/bin is in your $PATH'
  fi
}

doinstall() {
  mkdir -p ~/bin
  wget -q -O ~/bin/bai https://git.io/vdis9
  chmod +x ~/bin/*
}

checkdeps
setprofile
setpath
doinstall
