module Common (getTheme) where

import System.IO (hPutStrLn, stderr)
import Themes

themeName :: String
themeName = "nord"

putsErr :: String -> IO ()
putsErr = hPutStrLn stderr

getTheme ::  IO Theme
getTheme = do
  let logAndDefault err = do
        putsErr $ "themes: Could not load theme " ++ show themeName ++ ": " ++ err
        putsErr  "themes: Using default (ugly) theme."
        return defaultTheme
  theme_res <- fetchTheme themeName
  either logAndDefault return theme_res
