# dotfiles

Ah, home. Sweet home. And I'm not talking about your roof, but more specifically `$HOME`. This place is the one of the most disorganised places on a dev's
computer, only `/usr/lib` and `/usr/bin` cause more havoc. But it is indeed the most beloved one.

## How it looks

![screenshot](./screenshots/nord.png)

The theme is [nord based](https://www.nordtheme.com/), check them out, the nord team is doing a great job!<br>
Also, as a sidenote, disable your dark reader on the website, it'll mess up the colors. Use the night theme moon on the right corner of the page.

The wallpaper is from [this awesome person](https://raw.githubusercontent.com/Blu3Jive001/Wallpapers/master/Nordic/Simplistic/Minimal-Nord.png), 
under `Nordic/Simplistic/Minimal-Nord.png`.

## What is being used in the screenshot?

I try my best to keep my dotfiles simple and only put things that I'm currently using. Sadly, this is not always possible, specially in the case of window manager configuration,
so I'm going to list only the configurations relevant to the config from the screenshot:
  - [polybar](./.config/polybar): The three bars at the top.
  - [i3](./.config/.i3/config): I'm using [i3-gaps](https://github.com/Airblader/i3) as my window manager.
  - [alacritty](./.config/alacritty/alacritty.yml): If you're not going to use `tmux`, remove the `shell` key and alacritty will use your default shell.
  - [neovim](./.config/nvim): It is a submodule, so I'd init it if you want to try it. It's completely complementary, not needed for the looks
  - [fish](./.config/fish): My current shell.
  - [picom](./.config/picom): I use [ibhagwan's variant](https://github.com/ibhagwan/picom) of picom to get rounded corners. You have to install it manually, or `picom-ibhagwan-git` from the AUR if you use Arch Linux.
  - [tmux](./.tmux.conf): Don't forget about tpm in `.tmux/plugins/tpm`, it is a necessary submodule if you want to have my tmux config.

## Font

The font is `Fantasque Sans Mono`, the [Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono) variant. Everywhere, as far as I'm concerned.

## How to clone it

If you want to test some parts out, I suggest doing

```sh
git clone --recurse-submodules https://github.com/CyberGsus/dotfiles cybergsus-dotfiles
```


and **reading** the config files of whatever you're trying so you don't miss on details.

The tmux config will require you to press `<prefix>+I` (shift included) so it downloads
the extra plugins. It only comes with [`tpm`](https://github.com/tmux-plugins/tpm) to be able to install them.

Use
```sh
tmux -f cybergsus-dotfiles/.tmux.conf
```
to run it inside a separate terminal session (with alacritty, you would do `alacritty -e` plus the thing above) and **not messing yours up**.

## Tips 

For managing dots, I strongly recommend the [atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles).
