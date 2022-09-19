module Main where

import           Control.Monad.RWS.Strict
import           Control.Monad.State
import           Module.AppTypes
import           Module.MonadRWST
import           Module.RpnSafe

-- []
-- (,,)
-- data  Maybe a  =  Nothing | Just a
-- data  Either a b  =  Left a | Right b
-- data NonEmpty a = a :| [a]
-- IO
runMyApp :: MyApp logEntry state a -> AppConfig -> state -> IO (a, [logEntry])
runMyApp app config st = evalRWST app (initialEnv config) st

main = do
  let res = runStateT calculate []
  print res
