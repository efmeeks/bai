# Better Apt Installer

Install apt packages with `bai package(s)`

*Requires Linux environment with apt package manager. (obviously)*

> Note: Piping to the shell can be dangerous. It’s always a good idea to check the [source](install.sh) first.

## Try
```bash
wget -q -O - file.efmeeks.net/bai/master/bai.sh | bash
```

## Install
```bash
wget -q -O - file.efmeeks.net/bai/master/install.sh | bash
```

## Usage
```
Better Apt Installer
http://git.efmeeks.net/bai

Usage:      bai <command> package(s)

Commands:   [h]elp    | Show help message
            [u]pdate  | Update, upgrade, and cleanup packages
            [i]nstall | (Optional) Install the following package(s)
            [r]emove  | Remove package(s)
            [d]elete  | Remove package(s)
            [s]earch  | Search for packages
```

## Source
```bash
#!/bin/bash

# Better Apt Installer
# http://git.efmeeks.net/bai

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
exit
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
  exit
}

install() {
  if [ -z "$2" ]; then
    echo 'Nothing to install. See `bai help`'
    exit
  else
    pre
    $apt install -y "${@:2}"
    exit
  fi
}

remove() {
  if [ -z "$2" ]; then
    echo 'Nothing to remove. See `bai help`'
    exit
  else
    pre
    $apt remove --purge "${@:2}"
    exit
  fi
}

search() {
  if [ -z "$2" ]; then
    echo 'Nothing to search for. See `bai help`'
    exit
  else
    pre
    $apt search "${@:2}"
    exit
  fi
}

[ "$1" == "s" -o "$1" == "search" ] && search "$@"
[ "$1" == "u" -o "$1" == "update" ] && update
[ "$1" == "i" -o "$1" == "install" ] && install "$@"
[ "$1" == "d" -o "$1" == "delete" ] && remove "$@"
[ "$1" == "remove" -o "$1" == "r" ] && remove "$@"
[ -z "$1" -o "$1" == "help" -o "$1" == "h" ] && usage || usage

```