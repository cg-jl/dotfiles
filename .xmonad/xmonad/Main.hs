module Main (main) where

-- import Data.Tree

import Common
import Data.List (mapAccumL)
import Data.Monoid
import System.Exit (exitSuccess)
import System.IO (Handle, IOMode (ReadWriteMode, WriteMode), hGetContents, hGetLine, hPutStr, hPutStrLn, stderr, withFile)
import Themes
import XMonad
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (nextScreen, prevScreen)
import XMonad.Actions.MouseResize
import XMonad.Actions.UpdatePointer
import XMonad.Actions.WithAll (sinkAll)
import XMonad.Hooks.DynamicLog (PP (..), dynamicLogWithPP, shorten, wrap, xmobarColor, xmobarPP)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks (ToggleStruts (..), avoidStruts, docksEventHook, manageDocks)
import XMonad.Hooks.ManageHelpers (doFullFloat, isFullscreen)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory
import XMonad.Layout.GridVariants (Grid (Grid))
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows)
import XMonad.Layout.MultiToggle (EOT (EOT), mkToggle, single, (??))
import qualified XMonad.Layout.MultiToggle as MT (Toggle (..))
import XMonad.Layout.MultiToggle.Instances (StdTransformers (MIRROR, NBFULL, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed (Rename (Replace), renamed)
import XMonad.Layout.ResizableTile
import XMonad.Layout.ShowWName
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import qualified XMonad.Layout.ToggleLayouts as T (ToggleLayout (Toggle), toggleLayouts)
import XMonad.Layout.WindowArranger (WindowArrangerMsg (..), windowArrange)
import XMonad.Operations (restart)
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce

myModMask = mod4Mask :: KeyMask

myTerminal = "alacritty" :: String

myNormColor = "#2e3440" :: String

myFocusColor = "#e5e9f0" :: String

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
  setWMName "xmonad"

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Single window with no gaps
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Layouts definition

tall =
  renamed [Replace "tall"] $
    limitWindows 12 $
      mySpacing 4 $
        ResizableTall 1 (3 / 100) (1 / 2) []

monocle = renamed [Replace "monocle"] $ limitWindows 20 Full

grid =
  renamed [Replace "grid"] $
    limitWindows 12 $
      mySpacing 4 $
        mkToggle (single MIRROR) $
          Grid (16 / 10)

threeCol =
  renamed [Replace "threeCol"] $
    limitWindows 7 $
      mySpacing' 4 $
        ThreeCol 1 (3 / 100) (1 / 3)

floats = renamed [Replace "floats"] $ limitWindows 20 simplestFloat

-- Layout hook

myLayoutHook =
  avoidStruts $
    smartBorders $
      mouseResize $
        windowArrange $
          T.toggleLayouts floats $
            mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout =
      noBorders monocle
        ||| tall
        ||| threeCol
        ||| grid

mapIndices :: Num b => (b -> a -> c) -> b -> [a] -> [c]
mapIndices f start = snd . mapAccumL (\i b -> (i + 1, f i b)) start

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
    doubleLts '<' = "<<"
    doubleLts x = [x]

myWorkspaces :: [String]
myWorkspaces =
  clickable
    ["\xf269 ", "\xe795 ", "\xf121 ", "\xe615 ", "\xf74a "]
  where
    -- [" ", " ", " ", " ", " "]

    clickable = mapIndices mkAction 1

    mkAction :: Int -> String -> String
    mkAction index workspace = "<action=xdotool key super+" ++ show index ++ ">" ++ workspace ++ "</action>"

myKeys :: [(String, X ())]
myKeys =
  [ ------------------ Window configs ------------------

    -- Move focus to the next window
    ("M-j", windows W.focusDown),
    -- Move focus to the previous window
    ("M-k", windows W.focusUp),
    -- Swap focused window with next window
    ("M-S-j", windows W.swapDown),
    -- Swap focused window with prev window
    ("M-S-k", windows W.swapUp),
    -- Kill window
    ("M-w", kill1),
    -- Restart xmonad
    ("M-C-r", restart "xmonad" True), -- for more info look at: xmonad-git/XMonad/Main.hs#L159
    -- Quit xmonad
    ("M-C-q", io exitSuccess),
    ----------------- Floating windows -----------------

    -- Toggles 'floats' layout
    ("M-f", sendMessage (T.Toggle "floats")),
    -- Push floating window back to tile
    ("M-S-f", withFocused $ windows . W.sink),
    -- Push all floating windows to tile
    ("M-C-f", sinkAll),
    ---------------------- Layouts ----------------------

    -- Switch focus to next monitor
    ("M-.", nextScreen),
    -- Switch focus to prev monitor
    ("M-,", prevScreen),
    -- Switch to next layout
    ("M-<Tab>", sendMessage NextLayout),
    -- Switch to first layout
    ("M-S-<Tab>", sendMessage FirstLayout),
    -- Toggles noborder/full
    ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts),
    -- Toggles noborder
    ("M-S-n", sendMessage $ MT.Toggle NOBORDERS),
    -- Shrink horizontal window width
    ("M-S-h", sendMessage Shrink),
    -- Expand horizontal window width
    ("M-S-l", sendMessage Expand),
    -- Shrink vertical window width
    ("M-C-j", sendMessage MirrorShrink),
    -- Exoand vertical window width
    ("M-C-k", sendMessage MirrorExpand),
    -------------------- App configs --------------------

    -- Menu
    ("M-m", spawn "rofi -show drun"),
    -- Window nav
    ("M-S-m", spawn "rofi -show"),
    -- Browser
    ("M-b", spawn "brave"),
    -- File explorer
    ("M-e", spawn "nautilus"),
    -- Terminal
    ("M-<Return>", spawn myTerminal),
    -- Redshift
    ("M-r", spawn "redshift -O 2400"),
    ("M-S-r", spawn "redshift -xP"),
    -- screenshots
    ("M-s", spawn "spectacle -m"),
    ("M-S-s", spawn "spectacle -a"),
    ("M-C-s", spawn "spectacle -r"),
    --------------------- Hardware ---------------------

    -- Volume
    ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
    -- Brightness
    ("<XF86MonBrightnessUp>", spawn "brightnessctl set +10%"),
    ("<XF86MonBrightnessDown>", spawn "brightnessctl set 10%-")
  ]

main :: IO ()
main = do
  theme <- getTheme "XMonad"
  let themeColor = (`colorString` theme)
  xmobarPipe <- spawnPipe "~/.local/bin/xmobar"
  -- Xmonad
  launch $
    ewmh
      def
        { manageHook = insertPosition Master Newer <+> manageDocks <+> (isFullscreen --> doFullFloat),
          handleEventHook = docksEventHook,
          modMask = myModMask,
          terminal = myTerminal,
          startupHook = myStartupHook,
          layoutHook = myLayoutHook,
          workspaces = myWorkspaces,
          borderWidth = 5,
          normalBorderColor = themeColor (normal . borders),
          focusedBorderColor = themeColor (focused . borders),
          -- Log hook
          logHook =
            workspaceHistoryHook
              <+> dynamicLogWithPP
                xmobarPP
                  { ppOutput = hPutStrLn xmobarPipe,
                    -- Current workspace in xmobar
                    ppCurrent = xmobarColor (themeColor Themes.focus) "" . mkWrap,
                    -- Visible but not current workspace
                    ppVisible = xmobarColor "#81a1c1" "" . mkWrap,
                    -- Hidden workspaces in xmobar
                    ppHidden = xmobarColor (themeColor hidden) "" . mkWrap,
                    -- Hidden workspaces (no windows)
                    ppHiddenNoWindows = xmobarColor (themeColor hidden) "" . mkWrap,
                    -- Title of active window in xmobar
                    ppTitle = xmobarColor (themeColor Themes.title) "" . shorten 55,
                    -- Separators in xmobar
                    ppSep = "<fc=" ++ themeColor separators ++ "> :: </fc>",
                    -- Urgent workspace
                    ppUrgent = xmobarColor (themeColor urgent) "",
                    -- Number of windows in current workspace
                    ppExtras = [windowCount],
                    ppOrder = \(ws : l : t : ex) -> [ws, l] ++ ex ++ [t]
                  }
              >> updatePointer (0.5, 0.5) (0.5, 0.5)
        }
      `additionalKeysP` myKeys
  where
    mkWrap = wrap " " " "
