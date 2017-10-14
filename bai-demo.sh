#!/bin/bash

# Better Apt Installer
# http://git.efmeeks.net/bai
# bai-demo.sh

tmp="/tmp/bai-demo.sh"
wget -q -O $tmp file.efmeeks.net/bai/master/bai.sh
chmod +x $tmp
alias bai='$tmp'
type bai
cat << eof
It will be automatically removed at the next system reboot
To remove it manually, run `rm -v $tmp; unalias bai`

Usage: bai <command> package(s)
eof
