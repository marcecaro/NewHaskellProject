
{-
Example of Reverse Poland Notation combining two monads
-}
module LearningSamples.Samples.Rpn where
import Control.Monad.State.Class ( MonadState(put, state, get) )
import Control.Monad.State ( runState, State )


type Stack = [Int]   -- My Current Status


push::Int->State Stack Int   -- Add an state transition where the state has a new element
push n = Control.Monad.State.Class.state $ \xs -> (0, n:xs)

pop::State Stack Int    -- Take the current state, remove its head and use it as the new returned value
pop = do 
        stack <- Control.Monad.State.Class.get
        Control.Monad.State.Class.put $ tail stack
        return $ head stack


plus::State Stack Int   -- Take two numbers from the state and add it. return it as the new value, update the state
plus = do
            x <- pop
            y <- pop
            let res = x+y
            push res
            return res


end::State Stack Int
end = do pop


calculate::State Stack Int
calculate = do 
                push 1
                push 2
                plus
                push 10
                plus
                end

main = do
        let res = Control.Monad.State.runState  calculate []
        print res

        