module XmobarConfig.Main (main) where

-- import Xmobar.Plugins.HandleReader

import Common
import System.IO (Handle, hFlush, hPutStrLn, stderr, stdout)
import Themes
import Xmobar

xmobarColor :: String -> String -> String
xmobarColor col msg = "<fc=" ++ col ++ ">" ++ msg ++ "</fc>"

mkConfig :: Handle -> Theme -> Config
mkConfig handle theme =
  let themeColor = (`colorString` theme)
      sep = xmobarColor (themeColor separators) " :: "
   in defaultConfig
        { font = "xft:FantasqueSansMono Nerd Font:weight=bold:pixelsize=16:antialias=true:hinting=true",
          bgColor = themeColor background,
          fgColor = themeColor text,
          lowerOnStart = True,
          hideOnStart = False,
          allDesktops = True,
          additionalFonts = ["Noto Sans Mono:pixelsize=16"],
          persistent = True,
          commands =
            [ -- 
              Run $ Date "\xf5ef  %d %b %Y %H:%M" "date" 10,
              Run $ Com "/home/cyber/.config/xmobar/scripts/brightness" [] "brightness" 10,
              Run $ Com "bash" ["-c", "checkupdates | wc -l"] "updates" 3000,
              Run $ Com "./.config/xmobar/scripts/trayer-padding-icon.sh" [] "trayerpad" 10,
              Run $ Kbd [("es", "ES"), ("us", "US"), ("us(dvorak)", "DV US")],
              Run $ Network "wlan0" [] 10,
              Run $ Battery ["-t", "<leftvbar> <left>%"] 100,
              Run $ Alsa "default" "Master" ["-t", "<volume>% 墳"],
              Run $ HandleReader handle "input"
            ],
          alignSep = "}{",
          -- 
          template =
            " \xe61f " ++ sep
              ++ "%input% }{\
                 \%kbd%"
              ++ sep
              ++ "<action=`amixer set Master toggle` button=1>"
              ++ xmobarColor (themeColor focus) "%alsa:default:Master%"
              ++ "</action>"
              ++ sep
              ++ xmobarColor "#ebcb8b" "%date%"
              ++ sep
              ++ "%trayerpad%"
        }


main :: Handle -> Theme -> IO ()
main handle theme = do
  let conf = mkConfig handle theme
  xmobar conf
