# ghc-relinking-avoidance-bug
Test case showing that GHC 7.8.4 doesn't relink when it should (since library code changed)

## Reproduce

Run `make` (on Linux).

## Description

`myexe` is an executable that depends on `mylib`, whose `myfun = putStrLn "output 1"`.

If we install `mylib`, compile `myexe`, then change mylib's code to `myfun = putStrLn "output 2"`,
re-install it, and then compile `myexe`,
then GHC does *not* notice that the library code changed.

It avoids re-linking `myexe`,
with the result that the program prints `output 1` when you told it to compile against code
that prints `output 2`.
