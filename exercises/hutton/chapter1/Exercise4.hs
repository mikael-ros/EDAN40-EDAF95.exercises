module Exercise4 where
    nums = [2,5,8,1] -- The input... since I couldn't be bothered with System.environment --

    -- What follows is a straight copy from the book, --
    -- but with the modifications necessary for reverse order --
    qsort [] = [] 
    qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
                    where
                        smaller = [a | a <- xs, a >= x]
                        larger = [b | b <- xs, b < x]

    main = do -- This is the part executed after compilation --
        putStrLn (show (qsort nums)) -- Show is necessary to print the result --