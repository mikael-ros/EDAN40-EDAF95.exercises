module ClassOneLists where
    ----------------------
    -- -- Exercise 1 -- --
    ----------------------
    multiply :: Num a => [a] -> a
    multiply = foldr1 (*) -- Like the exercise sheet points out, this is just product. VSCode, in fact, really reallly wants me to switch it out to product lol

    ----------------------
    -- -- Exercise 2 -- --
    ----------------------
    substitute :: Eq character => character -> character -> [character] -> [character]
    substitute _ _ [] = []
    substitute toreplace replacer string = map (\letter -> if letter == toreplace then replacer else letter) string

    ----------------------
    -- -- Exercise 3 -- --
    ----------------------
    duplicates :: Eq number => [number] -> Bool
    duplicates [] = False -- To exhaust possibilities
    duplicates (current:restnumbers)
        | current `elem` restnumbers = True                   -- If current is also an element of the rest, then it is has a duplicate --
        | otherwise                  = duplicates restnumbers -- Otherwise continue with the rest of the list --