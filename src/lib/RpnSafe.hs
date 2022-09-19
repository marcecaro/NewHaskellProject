{-
Example of Reverse Poland Notation combining two monads
-}
module Project.RpnSafe where

import           Control.Monad.State

type Stack = [Int] -- My Current Status

push :: Int -> (StateT Stack Maybe) Int -- Add an state transition where the state has a new element
push n = state $ \xs -> (0, n : xs)

pop :: (StateT Stack Maybe) Int -- Take the current state, remove its head and use it as the new returned value
pop = do
  stack <- get
  when (null stack) $ lift Nothing -- Key point, the steps below are ignored due to the Nature of Maybe
  put (tail stack)
  return $ head stack

plus :: (StateT Stack Maybe) Int -- Take two numbers from the state and add it. return it as the new value, update the state
plus = do
  x <- pop
  y <- pop
  let res = x + y
  _ <- push res
  return res

end :: (StateT Stack Maybe) Int
end = pop

calculate :: (StateT Stack Maybe) Int
calculate = do
  _ <- push 1
  _ <- push 2
  _ <- plus
  _ <- push 10
  _ <- plus
  end

calculateWithFailure :: (StateT Stack Maybe) Int
calculateWithFailure = do
  _ <- push 1
  _ <- push 2
  _ <- plus
  _ <- push 10
  _ <- plus
  _ <- plus
  end

main :: IO ()
main = do
  let res = runStateT calculate []
  print res

mainFailure :: IO ()
mainFailure = do
  let res = runStateT calculateWithFailure []
  print res
