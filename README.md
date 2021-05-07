# dotfiles

Ah, home. Sweet home. And I'm not talking about your roof, but more specifically `$HOME`. This place is the one of the most disorganised places on a dev's
computer, only `/usr/lib` and `/usr/bin` cause more havoc. But it is indeed the most beloved one.

## How it looks

![screenshot](./screenshots/nord.png)

The theme is [nord-based](https://www.nordtheme.com/), check them out, the nord team is doing a great job!
Also, as a sidenote, disable your dark reader on the website, it'll mess up the colors. Use the night theme moon on the right corner of the page.

I'm not sure if the license of my background file allows me to distribute it, so
I won't. Just search for 'nordic' wallpapers and you might see it.

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

The xmonad config requires `stack` and you need to run `./build` the first time,and make sure you use the binary resulting in
the same directory (in my case it was `xmonad-x86-64-linux`) when instatiating it. When testing the xmonad config,
**please** use [Xephyr](https://wiki.archlinux.org/title/Xephyr) so you don't mess up your current desktop config:

```sh
Xephyr -br -ac -noreset -screen 1280x720 :1
```

and then running xmonad like this:

```sh
DISPLAY=:1 </path/to/xmonad>
```

That way you won't have to install it completely. I completely discourage from installing.

## Tips 

Finally, I came across a tutorial which told me how to 
set it up and not be a pain to update it.


I ran this:


```sh
git --bare ~/.cfg # ~/.cfg is the directory containing the git repo, don't f with it!
```

then added this line to my fish config:

```sh
alias git-dots="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
```

and **resourced the config**

finally, told git not to annoy me with thousands of untracked

```sh
git-dots config --local status.showUntrackedFiles no
```

This is my specialization of the [atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles). 



