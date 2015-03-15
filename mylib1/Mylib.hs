module Mylib (myfun) where

{-# NOINLINE myfun #-}
myfun :: IO ()
myfun = putStrLn "output 1"
