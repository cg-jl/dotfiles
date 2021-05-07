Config { font = "xft:FantasqueSansMono Nerd Font:weight=bold:pixelsize=14:antialias=true:hinting=true",
    bgColor = "#2e3440",
    fgColor = "#eceff4",
    lowerOnStart = True,
    hideOnStart = False,
    allDesktops = True,
    additionalFonts = [ "Noto Sans Mono:pixelsize=14" ]
    persistent = True,
    commands = [ 
        Run Date "  %d %b %Y %H:%M " "date" 10,
        Run Com "/home/cyber/.config/xmobar/scripts/brightness" [] "brightness" 10,
        Run Com "bash" ["-c", "checkupdates | wc -l"] "updates" 3000,
        Run Com "./.config/xmobar/scripts/trayer-padding-icon.sh" [] "trayerpad" 10,
        Run Kbd [("es", "ES"), ("us", "US"), ("us(dvorak)", "DV US")],
        Run Network "wlan0" [] 10,
        Run Battery ["-t", "<leftvbar> <left>%"] 100,
        Run Alsa "default" "Master" ["-t", "<volume>% 墳"],
        Run UnsafeStdinReader
    ],
    alignSep = "}{",
    template = "   <fc=#3b4252>:: </fc>%UnsafeStdinReader% }{\
        \%kbd%<fc=#3b4252> ::</fc>\
        \<action=`amixer set Master toggle` button=1><fc=#8fbcbb> %alsa:default:Master%</fc></action><fc=#3b4252> ::</fc>\
        \<fc=#ebcb8b> %date%</fc><fc=#3b4252>::</fc> %trayerpad%"
}
