{-# LANGUAGE InstanceSigs #-}
module Samples.Applicatives where
{-
class Functor f => Applicative f where
    pure :: a -> f a
    (<*>) :: f (a -> b) -> f a -> f b



Applicatives main functionality is to lift functions with more than one parameter.

Lifting is transform a function f::a->a1->a2->...->an into lifted_f::m a-> m a1 -> m a2 -> ... ->m an

The semantic of listed_f depends on the monad m, usualli is a combinatorial effect, as in Lists
-}


{- Example []
instance Applicative [] where
    pure x    = [x]
    fs <*> xs = [f x | f <- fs, x <- xs]
-}
example1 = pure (\a b c -> (a,b,c)) <*> [1,2,3] <*> [True, False] <*> ["Marcelo", "Carlos", "Pepe"]
---- [(1,True,"Marcelo"),(1,True,"Carlos"),(1,True,"Pepe"),(1,False,"Marcelo"),(1,False,"Carlos"),(1,False,"Pepe"),(2,True,"Marcelo"),(2,True,"Carlos"),(2,True,"Pepe"),(2,False,"Marcelo"),(2,False,"Carlos"),(2,False,"Pepe"),(3,True,"Marcelo"),(3,True,"Carlos"),(3,True,"Pepe"),(3,False,"Marcelo"),(3,False,"Carlos"),(3,False,"Pepe")]


-- Example Maybe
example2 = pure (\a b c -> (a,b,c)) <*> (Just 1) <*> (Just True) <*> (Just "Carlos") -- Just (1,True,"Carlos")
example3 = pure (\a b c -> (a,b,c)) <*> (Just 1) <*> (Nothing) <*> (Just "Carlos") -- Nothing


-- Example Either e
example4 = pure (\a b c -> (a,b,c)) <*> (Right 1) <*> (Right True) <*> (Right "Carlos") -- Right (1,True,"Carlos")


example5 = pure (\a b c -> (a,b,c)) <*> (Right 1) <*> (Left True) <*> (Right "Carlos") -- Left True 


-- Example IO
example6 = pure (\a b c -> (a,b,c)) <*> (print 1) <*> (print True) <*> (print "Carlos")-- Left True 



data Tree a = Leave a | Node a (Tree a) (Tree a)
                 deriving Show
                

instance Functor Tree where
  fmap:: (a -> b) -> Tree a -> Tree b
  fmap f (Leave x)    = Leave $ f x
  fmap f (Node x l r) = Node (f x) (fmap f l) (fmap f r)




-- The semantic will compose the two tree structure 
-- and will keep the last function when some part goes empty
instance Applicative Tree where
    pure = Leave  
  
    (<*>) :: Tree (a->b) -> Tree a -> Tree b
    (<*>) (Leave f) (Leave x) = Leave $ f x 
    (<*>) (Leave f) (Node x l2 r2) = Node (f x)  (Leave f <*> l2) (Leave f <*> r2)
    (<*>) (Node f l r) (Leave x) = Node (f x)  ( l <*> Leave x) ( r <*> Leave x) 
    (<*>) (Node f l r) (Node x l2 r2) = Node (f x) (l <*> l2) (r <*> r2)
    
  

example7 = pure (\a b c -> (a,b,c)) <*> (Node 1 (Leave 2) (Leave 3)) <*> (Node True (Leave False) (Leave True))  <*> (Node "Marcelo" (Leave "Carlos") (Node "Pepe" (Leave "Jorge") (Leave "Adrian")))

-- Node 1 
--  (Leave 2) 
--  (Leave 3))

-- Node True 
--      (Leave False) 
--      (Leave True))

-- Node "Marcelo" 
--  (Leave "Carlos") 
--  (Node "Pepe" 
--    (Leave "Jorge") 
--    (Leave "Adrian")))

--Node (1,True,"Marcelo") 
--    (Leave (2,False,"Carlos")) 
--    (Node (3,True,"Pepe") 
--       (Leave (3,True,"Jorge")) 
--       (Leave (3,True,"Adrian")))


 
