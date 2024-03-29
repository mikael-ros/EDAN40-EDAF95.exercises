module Exercise3 where
    nums = [2..4] -- The input... since I couldn't be bothered with System.environment --

    product [] = 1 -- Defined for the empty set --
    product (n:ns) = n * Exercise3.product ns  -- The method that calculates the product --

    productAlt xs = foldl (*) 1 xs  -- Alternative syntax for the same thing --

    main = do -- This is the part executed after compilation --
        putStrLn (show (Exercise3.product nums)) -- Show is necessary to print the result --