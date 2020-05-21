# dotfiles
My dotfiles. Handled by GNU-stow

## A note on GNU-stow
Stow is just a way of symlinking multiple directories. For example, you you have `~/dotfiles/<GROUP>/.config`. In this `<GROUP>/.config` folder you can have a collection of config files that are somehow related to each other.

If you execute `stow --target=$HOME <GROUP>` this will symlink `~/dotfiles/<GROUP>` to `$HOME`, effectively linking `~/dotfiles/<GROUP>/.config` to `$HOME/.config`.

A working example in my dotfiles is the X11 folder in my dotfiles. In this I included both the `xinit` config and the `xmodmap` configs. When I execute `stow --target=$HOME X11` I will then have both the `~/.config/xinit/xinitrc` and `~/.config/xmodmap/Xmodmap` files available to the system.

## To stow dotfiles
```bash
$ cd ~/Git/dotfiles
$ for i in $(ls); do
    stow --restow --target=$HOME $i
  done
```
