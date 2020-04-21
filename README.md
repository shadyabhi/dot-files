Table of Contents
=================

   * [Intro](#intro)
      * [Major features](#major-features)
      * [Repo workflow](#repo-workflow)
         * [Initialization](#initialization)
         * [Aliases](#aliases)
         * [Usage](#usage)
         * [Replication](#replication)
            * [First time](#first-time)
            * [Subsequent replication](#subsequent-replication)

# Intro

This repo contains all my `public` dot-files that are published on public interest.


## Major features

* .zshrc.d: Easy organization of zshrc configs
* .config/nvim: NVIM configs. nvim >> vim
* .tmux.conf: tmux for pane management
* .hammerspoon: Amazing automation software to config your Mac via lua scripts

## Repo workflow

I choose this workflow because it doesn't require me to install any new software.

### Initialization

```bash
# Public configs
git init --bare $HOME/.dot-files

# Private configs
git init --bare $HOME/.dot-files-private

# One time use, later we've aliases
gitdf  --git-dir=$HOME/.dot-files/ --work-tree=$HOME remote add origin git@github.com:shadyabhi/dot-files.git
```

### Aliases

```bash
alias gitdf='git --git-dir=$HOME/.dot-files/ --work-tree=$HOME'
alias gitdfpv='git --git-dir=$HOME/.dot-files-private/ --work-tree=$HOME'
gitdf config status.showUntrackedFiles no
```

### Usage

Here's how to add a new file. 

```bash
gitdf status
gitdf add .my-dot-file
gitdf commit -m 'Add new file'
gitdf push
```

### Replication

#### First time

```bash
git clone --separate-git-dir=$HOME/.dot-files https://github.com/shadyabhi/dot-files.git dot-files-tmp
rsync --recursive --verbose --exclude '.git' dot-files-tmp/ $HOME/
rm --recursive dot-files-tmp
```

#### Subsequent replication
```
# You can set this up as a cronjob on all other machines
gitdf pull
```
