# Xmonad/xmobar configuration

This is my (pretty minimal) xmonad configuration. I recommend checking out the [xmobar](../.config/xmobar) configuration as well as this config
will launch it on startup.


## How to set it up

First, you need [`stack`](https://docs.haskellstack.org/en/stable/README/) and the C build tools. You can get it with:

```sh
wget -qO- https://get.haskellstack.org/ | sh
```

Then run `stack install`, and make sure to have `$HOME/.local/bin` added to your `$PATH`, as the `xmobar` and `xmonad` binaries will be there.

### Troubleshooting

When running `stack install`, you may get an error like this:

```
$ stack install
alsa-mixer> configure
alsa-mixer> Configuring alsa-mixer-0.3.0...
alsa-mixer> build
alsa-mixer> Preprocessing library for alsa-mixer-0.3.0..
alsa-mixer> c2hs: Prelude.head: empty list
Progress 1/2

--  While building package alsa-mixer-0.3.0 (scroll up to its section to see the error) using:
      /home/cyber/.stack/setup-exe-cache/x86_64-linux-tinfo6/Cabal-simple_mPHDZzAJ_3.0.1.0_ghc-8.8.4 --builddir=.stack-work/dist/x86_64-linux-tinfo6/Cabal-3.0.1.0 build --ghc-options " -fdiagnostics-color=always"
    Process exited with code: ExitFailure 1
```

Just use `LANG=C stack install` and it will work. Refer to [this reddit post](https://www.reddit.com/r/haskell/comments/l42m06/installing_xmonad_via_stack_alsamixer_c2hs/) for more information.
