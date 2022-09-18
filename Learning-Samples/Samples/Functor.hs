{-# LANGUAGE InstanceSigs #-}
module Samples.Functor where
 
{-
Functor examples 

fmap:: (Functor f) => a -> b -> f a -> f b

Instances:
 []
 (,)
 data  Maybe a  =  Nothing | Just a
 data  Either a b  =  Left a | Right b
 IO
 custom data structure
-}




-- example on []
example1 = fmap (\x-> "_"++show x++"_") [1,2,3]   -- ["_1_","_2_","_3_"]


-- example on Maybe
example2  = fmap (\x-> "_"++show x++"_") (Just 1)  -- Just "_1_"
example2' = fmap (\x-> "_"++show x++"_") (Nothing)  -- Nothing
example3  = fmap (\x-> "_"++show x++"_") (Just (Just 1))  -- Just "_Just 1_"



-- example on Either
example4 = fmap (\x-> "_"++show x++"_") (Left 1)  -- Left 1     <<-- Ojo, solo applica a right
example5 = fmap (\x-> "_"++show x++"_") (Right 1) -- Right "_1_"


-- example on ()
example6 = fmap (\x-> "_"++show x++"_") (1, 2)  -- (1,"_2_")    <<-- Ojo, solo applica al right


-- example on IO
example7 = fmap (\x -> print x)  [1,2,3]  -- [IO ()], ready to be secuenced :)



-- example on custom data structure


data Tree a = Leave a | Node a (Tree a) (Tree a)
                 deriving Show
                

instance Functor Tree where
  fmap:: (a -> b) -> Tree a -> Tree b
  fmap f (Leave x)    = Leave $ f x
  fmap f (Node x l r) = Node (f x) (fmap f l) (fmap f r)

-- example on Tree
example8 = fmap (\x -> "_"++show x++"_") (Node 1 
                                            (Node 3 (Leave 1) (Leave 5) ) 
                                            (Leave 8)
                                          )
-- Node "_1_" (Node "_3_" (Leave "_1_") (Leave "_5_")) (Leave "_8_")
         