module ListsContinued where

    -----------------------
    -- -- Exercise 11 -- --
    -----------------------
    data Encoding a = Multiple Int a | Single a
        deriving (Eq, Show) -- necessary for tests, not really relevant for the solution

    pack :: Eq a => [a] -> [[a]]
    pack = reverse . flip packHelper [[]]

    packHelper :: Eq a => [a] -> [[a]] -> [[a]]
    packHelper [] _ = []
    packHelper list@(l:ls) packed
        | null ls = packed 
        | otherwise = packHelper (dropWhile (==l) ls) packed++[l:takeWhile (==l) ls]

    createEncoding :: [a] -> Encoding a
    createEncoding run@(r:rs)
        | null rs = Single r
        | otherwise = Multiple (length run) r 
    
    encodeModified :: Eq a => [a] -> [Encoding a]
    encodeModified = map createEncoding . pack

    -----------------------
    -- -- Exercise 12 -- --
    -----------------------
    type EncodeTuple a = (Int, a)

    decodeEncoding :: Encoding a -> EncodeTuple a
    decodeEncoding e = case e of 
        Single r -> (1,r)
        Multiple l r -> (l,r)
    
    decode :: [Encoding a] -> [a] 
    decode = concatMap (uncurry replicate . decodeEncoding)

    -----------------------
    -- -- Exercise 13 -- --
    -----------------------
    encodeDirect :: Eq a => [a] -> [Encoding a]
    encodeDirect = reverse . flip encodeDirectHelper []

    encodeDirectHelper :: Eq a => [a] -> [Encoding a] -> [Encoding a]
    encodeDirectHelper [] _ = []
    encodeDirectHelper list@(l:ls) encoded
        | null ls = encoded 
        | otherwise = encodeDirectHelper (dropWhile (==l) ls) encoded++[createEncoding (l:takeWhile (==l) ls)]

    -----------------------
    -- -- Exercise 14 -- --
    -----------------------
    dupli :: [a] -> [a]
    dupli = concatMap (replicate 2)

    -----------------------
    -- -- Exercise 15 -- --
    -----------------------
    repli :: [a] -> Int -> [a]
    repli = flip $ concatMap . replicate

    -----------------------
    -- -- Exercise 16 -- --
    -----------------------
    dropEvery :: [a] -> Int -> [a]
    dropEvery list every = dropEveryHelper list [] every 1

    dropEveryHelper :: [a] -> [a] -> Int -> Int -> [a]
    dropEveryHelper [] acc _ _ = acc
    dropEveryHelper list@(l:ls) acc every index = dropEveryHelper ls newAcc every (index+1)
        where newAcc
                | index `mod` every == 0 = acc
                | otherwise = acc++[l]
    
    dropEvery' :: Eq a => [a] -> Int -> [a]
    dropEvery' list every = [a | a <- list, indexOf a list `mod` every /= 0]

    indexOf :: Eq a => a -> [a] -> Int -- this is the same as elemIndex from the Data.List module, but I wanted to define it myself too. It also avoids Maybe by returning -1 when an element isn't found - like most imperative languages
    indexOf el list = snd . head . filter fst $ zip (map (==el) list) (drop 1 (foldl (\acc e -> acc++[last acc + 1]) [0] list))++[(True,-1)] -- This is honestly the most hideous function I have ever created
    
    -----------------------
    -- -- Exercise 17 -- --
    -----------------------
    split, split' :: [a] -> Int -> ([a],[a])
    split list at = (slice list 0 (at-1), slice list (at+1) (length list))

    split' list at = (take at list, drop at list)

    -----------------------
    -- -- Exercise 18 -- --
    -----------------------
    slice :: [a] -> Int -> Int -> [a]
    slice list from to = take (to - from + 1) (drop (from - 1) list)

    -----------------------
    -- -- Exercise 19 -- --
    -----------------------
    rotate :: [a] -> Int -> [a]
    rotate list degree  = drop adjustedDegree list ++ take adjustedDegree list
        where adjustedDegree = (degree `mod` (2*length list)) `mod` length list

    -----------------------
    -- -- Exercise 20 -- --
    -----------------------
    removeAt, removeAt' :: Int -> [a] -> (a, [a])
    removeAt index list = (last firstHalf, init firstHalf ++ drop index list)
        where firstHalf = take index list

    removeAt' index list = (last fHalf, init fHalf ++ lHalf) -- defined using split
        where (fHalf, lHalf) = split list index