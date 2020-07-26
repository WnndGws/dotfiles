# dotfiles
My dotfiles. Handled by GNU-stow

## A note on GNU-stow
Stow is just a way of symlinking multiple directories. For example, you you have `~/dotfiles/<GROUP>/.config`. In this `<GROUP>/.config` folder you can have a collection of config files that are somehow related to each other.

If you execute `stow --target=$HOME <GROUP>` this will symlink `~/dotfiles/<GROUP>` to `$HOME`, effectively linking `~/dotfiles/<GROUP>/.config` to `$HOME/.config`.

A working example in my dotfiles is the X11 folder in my dotfiles. In this I included both the `xinit` config and the `xmodmap` configs. When I execute `stow --target=$HOME X11` I will then have both the `~/.config/xinit/xinitrc` and `~/.config/xmodmap/Xmodmap` files available to the system.

## To stow dotfiles
```bash
$ cd ~/git/dotfiles
$ for i in */; do
    stow --restow --target=$HOME $i
  done
```

* This will symlink all dotfiles in this repo.

## Checklist of utilities I use on each new PC
* NOTE: This is not an exhaustive list, only a way to remind myself of where to start.

- [x] xmodmap
- [x] static ip
- [x] trash-cli
- [x] starship
- [x] zsh
- [x] vim
- [x] scripts
- [x] alacritty
- [x] lemonbar
- [x] bspwm
- [x] sxhkd
- [x] firefox
- [x] gpg
- [x] ssh
- [x] git
- [x] zfs
- [x] aur-auto-vote
- [x] fail2ban
- [x] steam
- [x] sonarr
- [ ] radarr
- [x] sabnzbd
- [x] jellyfin
- [ ] mega.nz
- [x] rofi
- [x] newsboat
- [x] myman
- [ ] torrents
- [x] cmus
- [ ] wallpaper
- [ ] neomutt
- [x] XDG dirs
- [ ] Enable trim.timer if have sdd
