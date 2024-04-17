module ChapterSix where
    ----------------------
    -- -- Exercise 1 -- --
    ----------------------
    fac :: Int -> Int 
    fac 0 = 1
    fac n = n * fac (n-1)

    facFixed :: Int -> Int
    facFixed 0 = 1
    facFixed n
        | n > 1 = n * fac (n-1)
        | otherwise = 0

    ----------------------
    -- -- Exercise 2 -- --
    ----------------------
    sumdown :: Int -> Int
    sumdown n
        | n == 0 = n -- Instead of defining the base case outside, I opt to do it here as I find it more readable
        | n > 0 = n + sumdown (n-1)
        | otherwise = 0

    ----------------------
    -- -- Exercise 3 -- --
    ----------------------
    power :: Int -> Int -> Int
    power n p
        | n == 0 || p == 1 = n
        | p > 1 = n * power n (p-1)
        | otherwise = 0

    ----------------------
    -- -- Exercise 4 -- --
    ----------------------
    euclid :: Int -> Int -> Int
    euclid n1 n2
        | n1 < 0 || n2 < 0 = 0      -- Negative numbers 0 (undefined)
        | n1 == n2 = n1             -- If equal, return one of them (doesn't matter which)
        | otherwise = euclid (max n1 n2 - min n1 n2) (min n1 n2)

    ----------------------
    -- -- Exercise 6 -- --
    ----------------------
    and :: [Bool] -> Bool
    and (predicate:predicates)
        | null predicates = True
        | otherwise = predicate && ChapterSix.and predicates

    concat :: [[a]] -> [a]
    concat (list:lists)
        | null list = []        -- Should the list be entirely empty, we will get this, which will need to be handled
        | null lists = list
        | otherwise = list ++ ChapterSix.concat lists

    replicate :: Int -> a -> [a]
    replicate amount element
        | amount <= 0 = []
        | amount == 1 = [element]
        | otherwise = element : ChapterSix.replicate (amount - 1) element

    (!!) :: [a] -> Int -> a
    (!!) (element:list) index
        | index == 0 = element
        | otherwise = (ChapterSix.!!) list (index-1)

    elem :: Eq a => a -> [a] -> Bool
    elem query (element:list)
        | null list = False
        | query == element = True
        | otherwise = ChapterSix.elem query list

    ----------------------
    -- -- Exercise 7 -- --
    ----------------------