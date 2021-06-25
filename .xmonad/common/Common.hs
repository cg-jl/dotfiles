module Common (getTheme) where

import System.IO (hPutStrLn, stderr)
import Themes

themeName :: String
themeName = "nord"

putsErr :: String -> IO ()
putsErr = hPutStrLn stderr

getTheme :: String -> IO Theme
getTheme from = do
  let logAndDefault err = do
        putsErr $ from ++ "(themes): Could not load theme " ++ show themeName ++ ": " ++ err
        putsErr $ from ++ "(themes): Using default (ugly) theme."
        return defaultTheme
  theme_res <- fetchTheme themeName
  either logAndDefault return theme_res
