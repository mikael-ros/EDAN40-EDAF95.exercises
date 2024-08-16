module ClassOneLists where
    ----------------------
    -- -- Exercise 1 -- --
    ----------------------
    multiply :: Num a => [a] -> a
    multiply = foldr1 (*) -- Like the exercise sheet points out, this is just product. VSCode, in fact, really reallly wants me to switch it out to product lol

    ----------------------
    -- -- Exercise 2 -- --
    ----------------------
    substitute :: Eq character => character -> character -> [character] -> [character]
    substitute _ _ [] = []
    substitute toreplace replacer string = map (\letter -> if letter == toreplace then replacer else letter) string

    ----------------------
    -- -- Exercise 3 -- --
    ----------------------
    duplicates :: Eq number => [number] -> Bool
    duplicates [] = False -- To exhaust possibilities
    duplicates (current:restnumbers)
        | current `elem` restnumbers = True                   -- If current is also an element of the rest, then it is has a duplicate --
        | otherwise                  = duplicates restnumbers -- Otherwise continue with the rest of the list --

    ----------------------
    -- -- Exercise 4 -- --
    ----------------------
    pairs :: [a] -> [b] -> [(a,b)]
    pairs xs ys = [(x,y) | x <- xs, y <- ys]

    triads :: Integer -> [(Integer, Integer, Integer)]
    triads n = [(x,y,z) | x <- [1..n], y <- [x..n], z <- [y..n], x^2 + y^2 == z^2] 

    ----------------------
    -- -- Exercise 5 -- --
    ----------------------
    isPermutation :: Eq a => [a] -> [a] -> Bool
    isPermutation xs ys = all (==True) (map (`elem` (pairs ys ys)) (pairs xs xs))

    ----------------------
    -- -- Exercise 6 -- --
    ----------------------

    shortestAndLongest words = snlHelper words (head words, last words)

    snlHelper (word:words) current
        | length word < length (fst current) = snlHelper words (word, snd current)
        | length word > length (snd current) = snlHelper words (fst current, word)
        | null words = current
        | otherwise = snlHelper words current
    
    ----------------------
    -- -- Exercise 7 -- --
    ----------------------
    mystery :: [a] -> [a]
    mystery xs = foldr (++) [] (map (\y -> [y]) xs)