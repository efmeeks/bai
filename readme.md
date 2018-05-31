# Better Apt Installer

Install apt packages with `bai package(s)`

*Requires Linux environment with apt package manager. (obviously)*

> Note: Redirecting scripts directly to the shell *can* be dangerous. It's a good idea to check [the source](./bai.sh) first.

## Try
cURL
```bash
bash <(curl -sL https://raw.githubusercontent.com/efmks/bai/master/bai.sh) #command goes here (defaults to help)
```
wget
```bash
bash <(wget -q -O - https://raw.githubusercontent.com/efmks/bai/master/bai.sh) #command goes here (defaults to help)
```

## Install
cURL
```bash
bash <(curl -sL https://raw.githubusercontent.com/efmks/bai/master/bai.sh) install bai
```
wget
```bash
bash <(wget -q -O - https://raw.githubusercontent.com/efmks/bai/master/bai.sh) install bai
```

## Usage
```
Better Apt Installer
https://github.com/efmks/bai

Usage:      bai <command> package(s)

Commands:   [h]elp    | Show help message
            [u]pdate  | Update, upgrade, and cleanup packages
            [i]nstall | (Optional) Install the following package(s)
            [r]emove  | Remove package(s)
            [d]elete  | Remove package(s)
            [s]earch  | Search for packages
```