# dotfiles
My dotfiles. Handled by GNU-stow

## To stow dotfiles
```bash
$ cd ~/Git/dotfiles
$ for i in $(ls); do
    stow --restow --target=$HOME $i
  done
```
