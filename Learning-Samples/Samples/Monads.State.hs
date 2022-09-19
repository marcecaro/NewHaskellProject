{-# LANGUAGE FlexibleContexts #-}

module Samples.Monads.State where

import           Control.Monad.State
import           Control.Monad.State.Class

data Environment =
  Environment
    { logLevel  :: String
    , someState :: String
    }
  deriving (Show)

type MyState = State Environment

getInitialenvironment = Environment "DEBUG" "Initial State"

-- getSomeStringValue::String -> MyState String
getSomeStringValue s = return $ s ++ " Calculated"

-- businessLogic :: (MonadIO m, MonadState e m) => m String     -- Return code
businessLogic = do
  st <- get
  result <- getSomeStringValue (someState st)
  --liftIO (print result)
  put st {someState = "New State"}
  gets someState

main :: IO ()
main = do
  let result = runState businessLogic getInitialenvironment
  print result
  return ()
