module Arithmetic where
    import Data.List (nub)
    -----------------------
    -- -- Exercise 31 -- --
    -----------------------
    isPrime :: Int -> Bool 
    isPrime p = all ((/=) 0 . mod p) [2..pred p]

    -----------------------
    -- -- Exercise 32 -- --
    -----------------------
    myGCD :: Int -> Int -> Int
    myGCD a b
        | b == 0 = abs a
        | otherwise = myGCD b (a `mod` b)

    -----------------------
    -- -- Exercise 33 -- --
    -----------------------
    coprime :: Int -> Int -> Bool
    coprime = ((==) 1 .) . myGCD

    -----------------------
    -- -- Exercise 34 -- --
    -----------------------
    totient :: Int -> Int
    totient n = length (filter (coprime n) [1..pred n])

    -----------------------
    -- -- Exercise 35 -- --
    -----------------------
    primesTo :: Int -> [Int]
    primesTo 1 = []
    primesTo n = filter isPrime [2..n]

    smallestPrimeFactor :: Int -> Int
    smallestPrimeFactor n = head (filter (\p -> n `mod` p == 0) (primesTo n))

    primeFactors, primeFactors' :: Int -> [Int]
    primeFactors = primeFactorsHelper []

    primeFactorsHelper :: [Int] -> Int -> [Int]
    primeFactorsHelper acc n
        | spf == n = acc++[spf]
        | otherwise = primeFactorsHelper (acc++[spf]) (n `div` spf)
        where spf = smallestPrimeFactor n
        
    primeFactors' 1 = []
    primeFactors' n = smallestPrimeFactor n:(primeFactors' . (div <*> smallestPrimeFactor)) n

    -----------------------
    -- -- Exercise 36 -- --
    -----------------------
    primeFactorsMult :: Int -> [(Int, Int)]
    primeFactorsMult n = map (\pf -> (pf,(length . filter (==pf) . primeFactors) n)) ((nub . primeFactors) n)

    -----------------------
    -- -- Exercise 37 -- --
    -----------------------
    totientImproved :: Int -> Int
    totientImproved = product . map (\(p,m) -> pred p * p ^ pred m) . primeFactorsMult

    -----------------------
    -- -- Exercise 39 -- --
    -----------------------
    primesR :: Int -> Int -> [Int]
    primesR = (filter isPrime .) . enumFromTo

    -----------------------
    -- -- Exercise 40 -- --
    -----------------------
    goldbach :: Int -> (Int,Int)
    goldbach n = head $ [(p1,p2) | p1 <- pT, p2 <- pT, p1 + p2 == n]++[(0,0)] -- 0,0 tacked onto handle non-even numbers
        where pT = primesTo n

    -----------------------
    -- -- Exercise 41 -- --
    -----------------------
    goldbachList :: Int -> Int -> [(Int,Int)]
    goldbachList = ((map goldbach . filter even) .) . enumFromTo
    
    goldbachListFloor :: Int -> Int -> Int -> [(Int,Int)]
    goldbachListFloor f = (filter ((>) f . fst) .) . goldbachList