#!/bin/bash

# Better Apt Installer
# http://git.efmeeks.net/bai

[ -z $(which apt) ] && echo "apt is missing" && exit
[ -z $(which apt-get) ] && echo "apt-get is missing" && exit

getbai() {
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
    wget -q -O ~/bin/bai http://file.efmeeks.net/bai/master/install.sh
    chmod +x ~/bin/*
  }
  setprofile
  setpath
  doinstall
}

usage() {
  cat << eof
  
  Better Apt Installer
  
  Usage:      bai <command> package(s)
  Commands:   [h]elp    | Show help message
              [u]pdate  | Update, upgrade, and cleanup packages
              [i]nstall | (Optional) Install the following package(s)
              [r]emove  | Remove package(s)
              [d]elete  | Remove package(s)
              [s]earch  | Search for packages

eof
}

pre() {
  # am i root?
  if [ "$(whoami)" != "root" ]; then
    apt="sudo apt-get"
  else
    apt="apt-get"
  fi
}

update() {
  pre
  $apt update
  $apt upgrade -y
  $apt autoremove -y
}

install() {
  if [ "$2" == "bai" ]; then
    getbai
    [ -n "$(which bai)" ] && unalias bai
  elif [ -z "$2" ]; then
    echo 'Nothing to install. See `bai help`'
  else
    pre
    $apt install -y "${@:2}"
  fi
}

remove() {
  if [ "$2" == "bai" ]; then
    [ -n "$(which bai)" ] && rm $(which bai)
    [ -n "$(type bai 2>/dev/null)" ] && rm "$(type bai 2>/dev/null)" && unalias bai
    echo "bai has been removed"
  elif [ -z "$2" ]; then
    echo 'Nothing to remove. See `bai help`'
  else
    pre
    $apt remove --purge "${@:2}"
  fi
}

search() {
  if [ -z "$2" ]; then
    echo 'Nothing to search for. See `bai help`'
  else
    pre
    $apt search "${@:2}"
  fi
}

[ "$1" == "s" -o "$1" == "search" ] && search "$@"
[ "$1" == "u" -o "$1" == "update" ] && update
[ "$1" == "i" -o "$1" == "install" ] && install "$@"
[ "$1" == "r" -o "$1" == "remove" ] && remove "$@"
[ "$1" == "d" -o "$1" == "delete" ] && remove "$@"
[ "$1" == "h" -o "$1" == "help" -o -z "$1" ] && usage || usage
