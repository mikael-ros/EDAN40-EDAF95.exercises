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
    substitute replacer toreplace (character:string)
        | character == toreplace = replacer  : substitute replacer toreplace string
        | otherwise              = character : substitute replacer toreplace string
    -- Tried to make this readable, but I don't think it is --

    ----------------------
    -- -- Exercise 3 -- --
    ----------------------
    duplicate :: Eq number => [number] -> Bool
    duplicate (current:restnumbers)
        | current `elem` restnumbers = True                  -- If current is also an element of the rest, then it is has a duplicate --
        | otherwise                  = duplicate restnumbers -- Otherwise continue with the rest of the list --