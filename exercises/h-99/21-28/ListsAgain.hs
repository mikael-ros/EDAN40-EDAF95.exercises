module ListsAgain where
    import System.Random (randomRIO)
    import Control.Monad (replicateM)
    import Control.Monad.Random
    import System.Random.Shuffle
    import Data.List

    -----------------------
    -- -- Exercise 21 -- --
    -----------------------
    insertAt :: a -> [a] -> Int -> [a]
    insertAt insert list at = (take . pred) at list ++ insert:(drop  . pred) at list

    -----------------------
    -- -- Exercise 22 -- --
    -----------------------
    range :: Int -> Int -> [Int]
    range n m = [n..m]

    -----------------------
    -- -- Exercise 23 -- --
    -----------------------
    rndSelect :: [a] -> Int -> IO [a]
    rndSelect list amount = do
        let n = min amount (length list) 
        randomIndices <- replicateM n (randomRIO (0, length list - 1))
        return $ map (list !!) randomIndices

    -----------------------
    -- -- Exercise 24 -- --
    -----------------------
    uniqueSelect :: [a] -> Int -> IO [a]
    uniqueSelect list amount = do
        let n = min amount (length list) 
        randomIndices <- evalRandIO $ shuffleM [0..length list - 1]
        return $ take n $ map (list !!) randomIndices

    diffSelect :: Int -> Int -> IO [Int]
    diffSelect amount to = uniqueSelect [0..to] amount

    -----------------------
    -- -- Exercise 25 -- --
    -----------------------
    rndPermu :: [a] -> IO [a]
    rndPermu = uniqueSelect <*> length

    -----------------------
    -- -- Exercise 26 -- --
    -----------------------
    combinations :: Int -> [a] -> [[a]]
    combinations 0 _ = [[]]
    combinations pick list = [list !! index : next | 
                    index <- [0..(pred $ length list)], 
                    next <- combinations (pred pick) (drop (succ index) list)]

    -----------------------
    -- -- Exercise 27 -- --
    -----------------------
    -- guh

    -----------------------
    -- -- Exercise 28 -- --
    -----------------------
    -- a)
    lsort :: [[a]] -> [[a]]
    lsort = sortBy (\x y -> compare (length x) (length y))

    -- b)
    lfsort :: [[a]] -> [[a]]
    lfsort list = sortBy (\x y -> compare (countSameLength x list) (countSameLength y list)) list

    countSameLength :: [a] -> [[a]] -> Int 
    countSameLength query = length . filter (\z -> length z == length query) 