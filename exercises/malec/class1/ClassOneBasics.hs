module ClassOneBasics where
    ----------------------
    -- -- Exercise 1 -- --
    ----------------------
    -- See the official solutions for a prettier but equivalent solution --
    maxi :: (Ord a, Num a) => a -> a -> a
    maxi x y = if x - y < 0
                then y
                else x

    ----------------------
    -- -- Exercise 2 -- --
    ----------------------
    -- You can optionally also define this as two functions, the solutions show both variants, though with the | (guard) --
    sumsq :: Int -> Int
    sumsq n = if n > 0 
                then n*n + sumsq (n-1)
                else 0

    sumsqm :: Int -> Int
    sumsqm n = foldl (+) 0 (map (^2) [0..n]) -- The 0 is necessary, as foldl requires an int as it's initial accumulator argument, or it wont work --

    ----------------------
    -- -- Exercise 3 -- --
    ----------------------

    main = do 
        putStrLn (show (maxi 5 4)) -- Should give 5
        putStrLn (show (sumsq 5)) -- Should give 5*5 + 4*4 + 3*3 + 2*2 + 1*1 = 25 + 16 + 9 + 4 + 1 = 55