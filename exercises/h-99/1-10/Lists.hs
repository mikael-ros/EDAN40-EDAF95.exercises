module Lists where
    ----------------------
    -- -- Exercise 1 -- --
    ----------------------
    myLast, myLast' :: [a] -> a
    myLast = head . reverse

    myLast' (x:xs)
        | null xs = x -- When xs is empty it means there are no more items to iterate through, hence x is the only remaining item (last)
        | otherwise = myLast' xs

    ----------------------
    -- -- Exercise 2 -- --
    ----------------------
    myButLast, myButLast' :: [a] -> a
    myButLast (x:xs)
        | length xs == 1 = x
        | otherwise = myButLast xs 

    myButLast' xs = xs !! (length xs - 2)

    ----------------------
    -- -- Exercise 3 -- --
    ----------------------
    elementAt :: [a] -> Int -> a
    elementAt xs = (!!) xs . subtract 1

    ----------------------
    -- -- Exercise 4 -- --
    ----------------------
    myLength, myLength' :: [a] -> Int
    myLength = flip myLengthHelper 0

    myLengthHelper :: [a] -> Int -> Int
    myLengthHelper (x:xs) acc
        | null xs = nextVal
        | otherwise = myLengthHelper xs nextVal
        where nextVal = acc+1

    myLength' = foldl (\acc x -> acc + 1) 0

    ----------------------
    -- -- Exercise 5 -- --
    ----------------------
    myReverse, myReverse' :: [a] -> [a]
    myReverse = foldr (\el list -> list++[el]) []

    myReverse' = flip myReverse'Helper []

    myReverse'Helper :: [a] -> [a] -> [a]
    myReverse'Helper (x:xs) reversed
        | null xs = reversed++[x]
        | otherwise = myReverse'Helper xs reversed++[x]

    ----------------------
    -- -- Exercise 6 -- --
    ----------------------
    slice :: [a] -> Int -> Int -> [a] -- Takes elements from a certain index to another index
    slice list from to = take (to - from + 1) (drop from list)

    isPalindrome :: Eq a => [a] -> Bool
    isPalindrome list = slice list 0 (middle-1) == reverse (slice list (middle+1) (length list))
        where middle = length list `div` 2

    ----------------------
    -- -- Exercise 7 -- --
    ----------------------
    data NestedList a = Elem a | List [NestedList a]

    myFlatten :: NestedList a -> [a] -- Just calls myFlattenHelper without the need to supply the empty list
    myFlatten = flip myFlattenHelper [] 

    myFlattenHelper :: NestedList a -> [a] -> [a]
    myFlattenHelper (Elem a) flattened = a:flattened
    myFlattenHelper (List list) flattened = foldr myFlattenHelper [] list ++ flattened

    ----------------------
    -- -- Exercise 8 -- --
    ----------------------
    compress :: Eq a => [a] -> [a] 
    compress = foldr (\el -> (el:) . dropWhile (==el)) []

    ----------------------
    -- -- Exercise 9 -- --
    ----------------------
    pack :: Eq a => [a] -> [[a]]
    pack = reverse . flip packHelper [[]]

    packHelper :: Eq a => [a] -> [[a]] -> [[a]]
    packHelper [] _ = []
    packHelper list@(l:ls) packed
        | null ls = packed 
        | otherwise = packHelper (dropWhile (==l) ls) packed++[l:takeWhile (==l) ls]
        
    -----------------------
    -- -- Exercise 10 -- --
    -----------------------
    type EncodeTuple a = (Int, a) -- Just a synonym for the tuple, makes it slightly more readable

    encode, encode' :: Eq a => [a] -> [EncodeTuple a]
    encode = reverse . flip encodeHelper []

    encodeHelper :: Eq a => [a] -> [EncodeTuple a] -> [EncodeTuple a]
    encodeHelper [] _ = []
    encodeHelper list@(l:ls) encoded
        | null ls = encoded 
        | otherwise = encodeHelper (dropWhile (==l) ls) encoded++[(length (l:takeWhile (==l) ls), l)]

    encode' = map (\l -> (length l, head l)) . pack
        