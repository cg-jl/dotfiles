[Submodules]: #submodules


# dotfiles

As their name suggest, these are the configuration files & submodules I keep for
myself. I started this as a way to have an easy way to switch to new computers,
but I haven't done anything substantial besides distrohopping a couple of times.
I keep it though, not just because it *might* be useful in the future, but it
also acts as both a snapshot of what I currently like and a history line of how
my taste for work & colors has changed over time.

After many resets, I decided to do minimal setup, so now my desktop just has a
changed wallpaper, changed keyboard to us-dvp and `foot` as a terminal.

Please note that this repository is designed to be write-only (and only by me).
This README has instructions I've written in the past, partly because I wanted
to have a record of them, partly because I enjoy doing these as a some kind of
journal. There are things that may be out of date since I'm not using them (and
haven't got to cleaning them up yet), but most things I've written are there
because they've worked. If you really want to try them, do it, but I'm not sure
that I could help you if you had an issue while installing.

## Screenshot

I'm not including screenshots anymore since I haven't been consistent on
updating.

If you're checking this from a place you can contact me from and want to see how things look, just ask me for one!

## Module dependencies

Here's a list of what these dotfiles configure and a list of interesting links

- [`stow`](https://www.gnu.org/software/stow/): Read [Installing](#installing) and [Submodules].
- Wayland only:
    - [`sway`](https://swaywm.org/): See tips from the [i3 Migration Guide](https://github.com/swaywm/sway/wiki/i3-Migration-Guide)
        - Check the config to change the background! It doesn't use feh!
    - [`wofi`](https://hg.sr.ht/~scoopta/wofi): [sway config](sway/.config/sway)
    - [`foot`](https://codeberg.org/dnkl/foot): [config](foot/.config/foot), [themes](foot/themes) [Submodules]
- `tmux`: [config](./tmux) [Submodules]
    - I'm using [`t-smart-tmux-session-manager`](https://github.com/joshmedeski/t-smart-tmux-session-manager), which provides bindings for `zoxide`!
- `bat`: [config](bat/.config/bat). Needs the `bat/.config/catppuccin` submodule. [Submodules]
- `zsh`: [config](./zsh) [Submodules]
    - The config searches for `zoxide`, which I don't use much in the command
      line, but more through tmux. I'm discovering things like `zi` which runs a
      fuzzy finder too.

- `neovim` 0.9.5: [config](./nvim/.config/nvim) [Submodules]



## Installing

The way to install is using git and [stow]:

```sh
git clone git@github.com:cg-jl/dotfiles ~/.cybergsus-dots
```

To e.g symlink alacritty config:

```sh
cd ~/.cybergsus-dots
stow alacritty
```


### Submodules

Some configurations require submodules to load correctly (i.e nvim config is in
a separate repository, zsh autosuggestions/highlighting, tmux modules etc).

Before loading a config, make sure you have the submodules that correspond to
that section loaded. Let's say for example you want to load the zsh stuff:

```sh
cd ~/.cybergsus-dots
git submodule update --init zsh
# some git output later...
stow zsh
```

All modules that may need a submodule init have a link to this section.

## Using Nix

I've tried using `nix` and `home-manager` to configure my system. It's been a
pretty cool experience overall.

I've failed and fell back to using void linux, mostly because my hobby involves
switching between compiler toolchains a lot, which aren't usually available as
packages (understandably so). I might try the new `docker compose` commands for
that and later return to Nix, since it's pretty handy to always know what you're
using on your system. I'll keep these instructions though:

There's still a couple of parts that I haven't put into VCS, so they're
documented here:

-  <details><summary> (Nixos Only)Add into `/etc/nixos/configuration.nix`</summary>

```nix
// { config, pkgs, ... }:
let home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
      ./cachix.nix
    ];
    // ...
    nix = {
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
        package = pkgs.nixUnstable;
        extraOptions = ''
            experimental-features = nix-command flakes
        '';
        settings.trusted-users = [ "root" "gsus" ];
    };
    services.openssh.enable = true;
    environment.systemPackages = with pkgs; [ 
        # ensure I can have a minimal setup to debug any mishap!
        # git is needed to bootstrap
        git vim firefox
    ];
}
```
</details>
- Alternatively, [here](https://nix-community.github.io/home-manager/index.html#sec-install-standalone) you can find how to install home manager for any other linux.
- If needed, make sure you configure git to use `https://github.com/` instead of
`git@github.com:`, or add an SSH key to your github account. 

- Clone the repo, init `nvim` module and `stow nvim`.
- Remember to install cachix! [here you can find how to](https://docs.cachix.org/installation)
- `cachix use nix-community`
- `sudo nixos-rebuild switch`
- `home-manager switch --flake <cloned-repo>/nix`.
- You should be good to go!


