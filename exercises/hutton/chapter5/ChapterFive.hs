module ChapterFive where
    ----------------------
    -- -- Exercise 1 -- --
    ----------------------
    hundredSquares :: Integer
    hundredSquares = sum [x^2 | x <- [0..100]]

    ----------------------
    -- -- Exercise 2 -- --
    ----------------------
    grid :: Int -> Int -> [(Int, Int)]
    grid m n = [(x,y) | x <- [0..m], y <- [0..n]]

    ----------------------
    -- -- Exercise 3 -- --
    ----------------------
    square :: Int -> [(Int, Int)]
    square n = [(x,y) | (x,y) <- grid n n, x /= y]

    ----------------------
    -- -- Exercise 4 -- --
    ----------------------
    replicate :: Int -> a -> [a]
    replicate n element = [element | _ <- [1..n]]

    ----------------------
    -- -- Exercise 5 -- --
    ----------------------
    pyths :: Int -> [(Int,Int,Int)]
    pyths n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]

    ----------------------
    -- -- Exercise 6 -- --
    ----------------------
    factors :: Int -> [Int]
    factors n = [f | f <- [1..n-1], (n `mod` f) == 0]

    perfects :: Int -> [Int]
    perfects m = [p | p <- [1..m], p == sum (factors p)]

    ----------------------
    -- -- Exercise 7 -- --
    ----------------------
    seperateGenerators :: [(Integer,Integer)]
    seperateGenerators =  concat [ [ (x, y) | x <- [1,2] ] | y <- [3,4] ]

    ----------------------
    -- -- Exercise 8 -- --
    ----------------------
    positionsFind :: a -> [a] -> [Int]
    positionsFind query list = --