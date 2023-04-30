#!/bin/bash

grim -t png -g "$(slurp)" - | wl-copy -t "image/png"
