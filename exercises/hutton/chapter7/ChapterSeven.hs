module ChapterSeven where
    ----------------------
    -- -- Exercise 1 -- --
    ----------------------
    isEven :: Int -> Bool
    isEven x = x `mod` 2 == 0

    doubler :: Int -> Int
    doubler n = n*2

    doubleEvenNumbers :: [Int] -> [Int]
    doubleEvenNumbers xs = map doubler (filter isEven xs)

    ----------------------
    -- -- Exercise 2 -- --
    ----------------------
    all :: (a -> Bool) -> [a] -> Bool
    all p = and . map p

    any :: (a -> Bool) -> [a] -> Bool
    any p = or . map p

    takeWhile :: (a -> Bool) -> [a] -> [a]
    takeWhile _ [] = []
    takeWhile p (x:xs)
        | p x = x : ChapterSeven.takeWhile p xs -- if the predicate holds, prepend x to this list
        | otherwise = []                        -- if it doesn't, we want to "skip" the element and terminate.

    dropWhile :: (a -> Bool) -> [a] -> [a]
    dropWhile _ [] = []
    dropWhile p xl@(x:xs) -- xl just concatenates x:xs back to the original list
        | p x = ChapterSeven.dropWhile p xs -- if the predicate holds, throw away x
        | otherwise = xl                    -- if it doesn't, we want to return the remaining elements (and the head)

    ----------------------
    -- -- Exercise 3 -- --
    ----------------------
    map' f = foldr (\x xs -> f x:xs) []

    filter' p = foldr (\x xs -> if p x then x:xs else xs) []

    ----------------------
    -- -- Exercise 4 -- --
    ----------------------
    dec2int :: [Int] -> Int
    dec2int = foldl (\x y -> 10*x + y) 0

    ----------------------
    -- -- Exercise 5 -- --
    ----------------------
    curry :: ((a,b) -> c) -> a -> b -> c
    curry f = \x y -> f (x,y)

    uncurry ::  (a -> b -> c) -> ((a,b) -> c)
    uncurry f = \(a,b) -> f a b

    ----------------------
    -- -- Exercise 6 -- --
    ----------------------
    unfold :: (t -> Bool) -> (t -> a) -> (t -> t) -> t -> [a]
    unfold p h t x 
        | p x = []
        | otherwise = h x : unfold p h t (t x)