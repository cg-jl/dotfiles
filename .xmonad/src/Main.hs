module Main (main) where

import Common
import Control.Concurrent
import System.Process
import Control.Monad (void)
import qualified XmobarConfig.Main as XC
import qualified XmonadConfig.Main as XM

main :: IO ()
main = do
  theme <- getTheme
  (readEnd, writeEnd) <- createPipe
  void $ forkIO $ XC.main readEnd theme -- NOTE: should I manage this?
  XM.main writeEnd theme
