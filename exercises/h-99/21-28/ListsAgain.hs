module ListsAgain where
    import System.Random (randomRIO)
    import Control.Monad (replicateM)
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
        randomIndices <- replicateM n (randomRIO (0, length list - 1))
        return $ map (list !!) randomIndices

    diffSelect :: Int -> Int -> IO [Int]
    diffSelect amount to = uniqueSelect [0..to] amount