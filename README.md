# dotfiles

## Setup

```bash
git init --bare $HOME/.dot-files
git init --bare $HOME/.dot-files-private

alias gitdf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
gitdf remote add origin git@github.com:shadyabhi/dot-files.git
```

## Configuration
```bash
alias gitdf='git --git-dir=$HOME/.dot-files/ --work-tree=$HOME'
alias gitdfpv='git --git-dir=$HOME/.dot-files-private/ --work-tree=$HOME'
gitdf config status.showUntrackedFiles no
```

## Usage
```bash
gitdf status
gitdf add .gitconfig
gitdf commit -m 'Add gitconfig'
gitdf push
```

## Replication

### First time

```bash
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/shadyabhi/dotfiles.git dotfiles-tmp
rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/
rm --recursive dotfiles-tmp
```
### Subsequent replication

```
gitdf pull
```
