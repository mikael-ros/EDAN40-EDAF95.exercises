module ChapterTwo where
    ----------------------
    -- -- Exercise 3 -- --
    ----------------------
    n :: Int
    n = a `div` length xs
        where
            a = 10
            xs = [1,2,3,4,5]

    ----------------------
    -- -- Exercise 4 -- --
    ----------------------
    lastTake :: [a] -> [a]
    lastTake list = take (length list - 1) list

    lastHead :: [a] -> a
    lastHead list = head (reverse list)

    ----------------------
    -- -- Exercise 5 -- --
    ----------------------
    initDrop :: [a] -> [a]
    initDrop list = reverse (drop 1 (reverse list))

    initTail :: [a] -> [a]
    initTail list = reverse (tail (reverse list))