#!/bin/bash

/home/gsus/.local/bin/grim -t png -g "$(slurp)" - | /home/gsus/.local/bin/wl-copy -t "image/png"
