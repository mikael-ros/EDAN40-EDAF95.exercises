module ChapterOne where
    ----------------------
    -- -- Exercise 3 -- --
    ----------------------
    product :: [Int] -> Int
    product [] = 1 -- Defined for the empty set --
    product (n:ns) = n * ChapterOne.product ns  -- The method that calculates the product --

    productAlt :: [Int] -> Int
    productAlt xs = foldl (*) 1 xs  -- Alternative syntax for the same thing --

    ----------------------
    -- -- Exercise 4 -- --
    ----------------------
    -- What follows is a straight copy from the book, --
    -- but with the modifications necessary for reverse order --
    qsort :: Ord a => [a] -> [a]
    qsort [] = [] 
    qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
                    where
                        smaller = [a | a <- xs, a >= x]
                        larger = [b | b <- xs, b < x]

    ----------------------
    -- -- Exercise 5 -- --
    ----------------------
    -- What follows is a straight copy from the book, --
    -- but with the modifications given (remove = from a <= x) --
    qsortWrong :: Ord a => [a] -> [a]
    qsortWrong [] = [] 
    qsortWrong (x:xs) = qsortWrong smaller ++ [x] ++ qsortWrong larger
                    where
                        smaller = [a | a <- xs, a < x]
                        larger = [b | b <- xs, b > x]