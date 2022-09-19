module Main where
import           Module.RpnSafe
import           Control.Monad.State
-- []
-- (,,)
-- data  Maybe a  =  Nothing | Just a
-- data  Either a b  =  Left a | Right b
-- data NonEmpty a = a :| [a]
-- IO
main = do
  let res = runStateT calculate []
  print res
