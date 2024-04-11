module ChapterFour where
    ----------------------
    -- -- Exercise 1 -- --
    ----------------------
    halve :: [a] ->  [a]
    halve list = take (length list `div` 2) list 
    {- `div` rounds by default, no need for rounding unlike /, 
        this avoids awkward errors, but will provide the wrong result for uneven lengthed lists (not part of the task though) -}

    ----------------------
    -- -- Exercise 2 -- --
    ----------------------
    thirdHead :: [a] -> a
    thirdHead list
        | length list >= 3 = head (tail (tail list))

    thirdIndex :: [a] -> a
    thirdIndex list
        | length list >= 3 = list !! 2 -- indexing begins at 0, hence 3rd is index 2, as usual in programming

    thirdPattern :: [a] -> a
    thirdPattern (_:_:e:_) = e

    ----------------------
    -- -- Exercise 3 -- --
    ----------------------

    safetailCond :: [a] -> [a]
    safetailCond list = if null list then list else tail list 

    safetailGuard :: [a] -> [a]
    safetailGuard list
        | null list = list
        | otherwise = tail list

    safetailPattern :: [a] -> [a]
    safetailPattern (_:es) = es -- This works regardless of length, I think

    ----------------------
    -- -- Exercise 5 -- --
    ----------------------
    and' :: Bool -> Bool -> Bool
    and' a b =    if a then
                        if b then
                            True
                        else
                            False
                    else
                        False
    
    ----------------------
    -- -- Exercise 6 -- --
    ----------------------
    and'' :: Bool -> Bool -> Bool
    and'' a b =     if b then
                        True
                    else
                        False
    
