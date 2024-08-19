{-
 - This is the official solution document provided by Malec. It is appended here for ease of use, and is not intended to be any kind of infringement. If you object to this use, Malec, please feel free to contact me, and I will remove it promptly! :)
 -
 -}

---------------------------------------------------------------------

-- 1. (EDAF, EDAN)
f = flip $ (/) . (3-)
g = flip $ (flip map) . (filter odd) . (flip take (iterate (+1) 1))

-- 2. (EDAF)
g :: [Int] -> [String]

-- 3. (EDAF)
-- type - type synonym, no new type declared
-- data - new datatype
-- newtype - new datatype with only one unary constructor

-- 4. (EDAF) 
uncurry map

-- 5. (EDAF)
f n = [(a,b,c)| a <- [1..n], b<- [1..n], c<-[1..n], a<=b, b<=c, a^2 + b^2 == c^2]

-- 6. (EDAF)
-- (a)
data Proposition = Var String | And Proposition Proposition | Or Proposition Proposition | Not Proposition

--- (b)
vars :: Proposition -> [String]
vars (Var x) = [x]
vars (Or p1 p2) = nub $ (++) (vars p1) (vars p2)
vars (And p1 p2) = nub $ (++) (vars p1) (vars p2)
vars (Not p) = vars p

--- (c)
truthValue :: Proposition -> [(String, Bool)] -> Bool

findVal :: String -> [(String, Bool)] -> Bool
findVal name xs = fromJust $ lookup name xs

truthValue (Var x) vals = findVal x vals
truthValue (Not p) vals = not $ truthValue p vals
truthValue (And p1 p2) vals = (&&) (truthValue p1 vals) (truthValue p2 vals)
truthValue (Or p1 p2) vals = (||) (truthValue p1 vals) (truthValue p2 vals)

--- (d)
tautology :: Proposition -> Bool

valslist :: Proposition -> [[(String,Bool)]]

boolperms vs :: [String] -> [[(String,Bool)]]
boolperms [] = []
boolperms (x:[]) = [[(x,True)],[(x,False)]]
boolperms (x:xs) = (++) (map ((x,True):) $ boolperms xs) (map ((x,False):) $ boolperms xs)

valslist = boolperms . vars 

tautology p = and $ map (truthValue p) (valslist p)

--========================================================
-- EDAN

-- 2. (EDAN)
-- (a)
(.)(:) :: (a -> b) -> a -> [b] -> [b]
-- (b)
(:)(.) :: [(b -> c) -> (a -> b) -> a -> c] -> [(b -> c) -> (a -> b) -> a -> c]
-- (c)
((.):) :: [(b -> c) -> (a -> b) -> a -> c] -> [(b -> c) -> (a -> b) -> a -> c]
-- (d)
(:(.)) TYPFEL!
-- (e)
([]>>=)(\_->[(>=)]) :: Ord a => [a -> a -> Bool]

-- 3. (EDAN)

-- PROOF, TO BE WRITTEN

-- 4. (EDAN)

uncurry $ flip map

-- 5. (EDAN)
instance (Ord a, Ord b) => Ord (a,b) where
  (>) (a,b) (c,d) = (a > c) || ((a == c) && (b > d))
  (>=) (a,b) (c,d) = (a > c) || ((a == c) && (b >= d))
  (<) (a,b) (c,d) = (a < c) || ((a == c) && (b < d))
  (<=) (a,b) (c,d) = (a < c) || ((a == c) && (b <= d))
  max (a,b) (c,d)
    | (a,b) >= (c,d) = (a,b)
    | otherwise      = (c,d)
  min (a,b) (c,d)
    | (a,b) <= (c,d) = (a,b)
    | otherwise      = (c,d)

-- NOTE -- the original solution below does not give the lexicographic order
instance (Ord a) => Ord [a] where
   (>) xs ys   = (and (zipWith (>=) xs ys)) && (not (xs == ys))
   (>=) xs ys = (and (zipWith (>=) xs ys)) 
   (<) xs ys   = (and (zipWith (<=) xs ys)) && (not (xs == ys))
   (<=) xs ys = (and (zipWith (<=) xs ys)) 
   min xs ys
     | xs <= ys  = xs
     | otherwise = ys
   max xs ys
     | xs >= ys  = xs
     | otherwise = ys

-- while this one should
instance (Ord a) => Ord [a] where
  (>) [] [] = False
  (>) _ [] = True
  (>) [] _ = False
  (>) (x:xs) (y:ys) = (x > y) || (x == y) && xs > ys
  (>=) xs ys = (xs > ys) || (xs == ys)
  (<) [] [] = False
  (<) [] _ = True
  (<) _ [] = False
  (<) (x:xs) (y:ys) = (x < y) || (x == y) && xs < ys
  (<=) xs ys = (xs < ys) || (xs == ys)
  min xs ys
     | xs <= ys  = xs
     | otherwise = ys
  max xs ys
     | xs >= ys  = xs
     | otherwise = ys

   
-- 6. (EDAN)

-- (a)
f :: (Monad m, Num b) => m b -> m b -> m b
-- (b)
[2,4,8,4,8,16,6,12,24]
-- (c)
Nothing
-- (d)
return 5 :: (Monad m, Num a) => m a
-- (e)
""
-- (f)
[]


