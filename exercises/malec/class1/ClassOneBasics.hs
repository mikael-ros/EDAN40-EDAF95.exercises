module ClassOneBasics where
    ----------------------
    -- -- Exercise 1 -- --
    ----------------------
    -- See the official solutions for a prettier but equivalent solution --
    maxi :: (Ord a, Num a) => a -> a -> a
    maxi x y = if x - y < 0
                then y
                else x

    ----------------------
    -- -- Exercise 2 -- --
    ----------------------
    -- You can optionally also define this as two functions, the solutions show both variants, though with the | (guard) --
    sumsq :: Int -> Int
    sumsq n = if n > 0 
                then n*n + sumsq (n-1)
                else 0

    sumsqm :: Int -> Int
    sumsqm n = foldl (+) 0 (map (^2) [0..n]) -- The 0 is necessary, as foldl requires an int as it's initial accumulator argument, or it wont work --

    ----------------------
    -- -- Exercise 3 -- --
    ----------------------
    hanoi :: Int -> Int
    hanoi height 
        | height <= 0 = 0
        | otherwise = 1 + 2 * hanoi (height-1)

    ----------------------
    -- -- Exercise 4 -- --
    ----------------------

    nextFactor :: Int -> Int -> Int
    nextFactor number minFactor  
        | (number `mod` minFactor) == 0 = minFactor
        | otherwise = nextFactor number (minFactor+1)

    smallestFactor :: Int -> Int
    smallestFactor number = nextFactor number 2

    numFactors :: Int -> Int
    numFactors number = length (removeDuplicates (map (nextFactor number) [2..number]))

    -- Taken from official solutions, since I can't be bothered implementing it --
    removeDuplicates :: Eq a => [a] -> [a]
    removeDuplicates [] = []
    removeDuplicates [x] = [x]
    removeDuplicates (x:xs)
        | elem x xs  = removeDuplicates xs
        | otherwise  = x : removeDuplicates xs
    
    ----------------------
    -- -- Exercise 5 -- --
    ----------------------

    type Month = Integer
    -- Seperated onto lines for readability ^^ --

    monthLengths = [31,28,31,30,31,30,31,31,30,31,30,31]

    data ShortDate = ShortDate {
        year :: Integer,
        month :: Month
    } deriving Show
    -- An instance is created with ShortDate (year) (month) --
    -- I defined it to make the code more readable, though I'm not sure if it helped in the end --

    daysInMonth :: ShortDate -> Integer
    daysInMonth date
        | month date == 2 && year date `mod` 4 == 0 = monthLengths!! fromInteger (month date - 1) + 1 -- Add 1 when leap year and February --
        | month date >= 1 && month date <= 12       = monthLengths!! fromInteger (month date - 1)
        | otherwise = 0 -- When month not in range, don't bother
    
    data Date = Date {
        prefix :: ShortDate,
        day :: Integer
    }

    validDate :: Date -> Bool
    validDate date
        | day date >= 1 && day date <= daysInMonth (prefix date) = True -- Kind of looks stupid since I defined the daysInMonth from the ShortDate type --
        | otherwise = False
    -- This results in the ugly syntax "validDate (Date (ShortDate 2024 04) 32)", which I could fix by overloading but I don't know how at the moment --
    -- Another solution is to redefine the Date type --