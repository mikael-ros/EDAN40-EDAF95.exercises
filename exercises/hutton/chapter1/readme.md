# Chapter 1

## 1

This question is silly, I will be skipping it. I don't think it's very interesting to try out permutations of a calculation.

## 2

The sum function applies the + operand for every item in an array, and as such if that array consists of a sole element x it will always return x, because  x + nothing = x.

## 3

See [Exercise3.hs](Exercise3.hs). Here is the code in plaintext:
``` haskell
    module Main where
        nums = [2..4] -- The input... since I couldn't be bothered with System.environment --

        product [] = 1 -- Defined for the empty set --
        product (n:ns) = n * Main.product ns  -- The method that calculates the product --

        productAlt xs = foldl (*) 1 xs  -- Alternative syntax for the same thing --

        main = do -- This is the part executed after compilation --
            putStrLn (show (Main.product nums)) -- Show is necessary to print the result --
```

## 4
Just reverse the order, see [Exercise4.hs](Exercise4.hs). Plaintext:
``` haskell
    module Main where
        nums = [2,5,8,1] -- The input... since I couldn't be bothered with System.environment --

        -- What follows is a straight copy from the book, --
        -- but with the modifications necessary for reverse order --
        qsort [] = [] 
        qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
                        where
                            smaller = [a | a <- xs, a >= x]
                            larger = [b | b <- xs, b < x]

        main = do -- This is the part executed after compilation --
            putStrLn (show (Main.qsort nums)) -- Show is necessary to print the result --
```

## 5
See [Exercise5.hs](Exercise5.hs); Plaintext: 
``` haskell
    module Main where
        nums = [2,2,3,1,1] -- The input given by the hint --

        -- What follows is a straight copy from the book, --
        -- but with the modifications given (remove = from a <= x) --
        qsort [] = [] 
        qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
                        where
                            smaller = [a | a <- xs, a < x]
                            larger = [b | b <- xs, b > x]

        main = do -- This is the part executed after compilation --
            putStrLn (show (Main.qsort nums)) -- Show is necessary to print the result --
```
It only gives unique entries, since equal entries fall out of the ``smaller`` set.