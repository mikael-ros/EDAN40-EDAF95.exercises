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
    hanoi :: Int -> Int
    hanoi height 
        | height <= 0 = 0
        | otherwise = 1 + 2 * hanoi (height-1)

    ----------------------
    -- -- Exercise 4 -- --
    ----------------------

    nextFactor :: Int -> Int -> Int
    nextFactor number minFactor  
        | (number `mod` minFactor) == 0 = minFactor
        | otherwise = nextFactor number (minFactor+1)

    smallestFactor :: Int -> Int
    smallestFactor number = nextFactor number 2

    numFactors :: Int -> Int
    numFactors number = length (removeDuplicates (map (nextFactor number) [2..number]))

    -- Taken from official solutions, since I can't be bothered implementing it --
    removeDuplicates :: Eq a => [a] -> [a]
    removeDuplicates [] = []
    removeDuplicates [x] = [x]
    removeDuplicates (x:xs)
        | elem x xs  = removeDuplicates xs
        | otherwise  = x : removeDuplicates xs