-- 1
f :: Fractional a => a -> a -> a
f = flip (.) (3-) . flip (/)

g :: (Int -> a) -> Int -> [a]
g = flip (.) ((1:) . flip take (iterate (+1) 3)) . map

-- 4
sillyMap :: ([a], a -> b) -> [b]
sillyMap = uncurry . flip $ map

--5
--instance (Ord a, Ord b) => Ord (a,b) where
--    (<=) (a,b) (c,d) = a <= b && c <= d 

-- 6a
h :: (Monad m, Num b) => m b -> m b -> m b
h x y = do
    a <- x
    b <- y
    return (a*b)