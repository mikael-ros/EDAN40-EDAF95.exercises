module Exercise5 where
    nums = [2,2,3,1,1] -- The input given by the hint --

    -- What follows is a straight copy from the book, --
    -- but with the modifications given (remove = from a <= x) --
    qsort [] = [] 
    qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
                    where
                        smaller = [a | a <- xs, a < x]
                        larger = [b | b <- xs, b > x]

    main = do -- This is the part executed after compilation --
        putStrLn (show (qsort nums)) -- Show is necessary to print the result --