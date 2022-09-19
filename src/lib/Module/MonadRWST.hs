module Module.MonadRWST where

import           Control.Monad.RWS.Strict
import           Module.AppTypes

{- newtype RWST r w s m a =
      A monad transformed containing an environment of type r,
      collecting output of type w
      and an updatable state of type s
      to an inner monad of type m
 Idea from this paper: https://web.cecs.pdx.edu/~mpj/pubs/springschool95.pdf
-}
-- MyApp environment: AppEnv, ourput: [logEntry], state: state, innerMonad: IO
type MyApp logEntry state = RWST AppEnv [logEntry] state IO
