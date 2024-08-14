{- 
 - This is the official solution document provided by Malec. It is appended here for ease of use, and is not intended to be any kind of infringement. If you object to this use, Malec, please feel free to contact me, and I will remove it promptly! :)
 -
 -}

---------------------------------------------------------------------

{- Note that this file contains solution suggestions for both exams, EDAF95 and EDAN40, in that order -}

-- EDAF95
-- Question 1: point-free notation

f = (/).(3-) --(0.4p)
{- THIS ANSWER IS WRONG! THE CORRECT ONE BELOW: -}
f = (.) ((3-) .) (/)
g = flip map . flip take (iterate succ 1) --(0.6p)

-- Question 2: type derivation

map iterate :: [a -> a] -> [a -> [a]]
curry uncurry :: TYPE ERROR
uncurry curry :: ((a, b) -> c, a) -> b -> c
curry . uncurry :: (a -> b -> c) -> a -> b -> c
uncurry . curry :: ((a, b) -> c) -> (a, b) -> c

-- Question 3: functions

map f = foldr ((:).f) []
-- or equivalently
map f = foldr (\x xs -> f x : xs) []

filter f = foldr (\x xs -> if f x then x:xs else xs) []

-- Question 4: bind

-- (a) (0.4p)
eliminate1 :: a -> [b] -> Grid -> Maybe Grid
-- (b) (0.2p)
eliminate1 :: a -> [b] -> Grid -> [Grid]
-- (c) (0.4p)
-- YES, just another monadic type used, i.e. lists instead of Maybe

-- Question 5: programming

-- 0.4p
data CircList a = CircList [a] deriving Show
-- (deriving not necessary for getting full points)

-- 0.1p
perimeter (CircList l) = length l
-- 0.2p
currentelem (CircList l) = listToMaybe l

listToMaybe [] = Nothing
listToMaybe xs = Just $ head xs
-- 0.1p
nextelem (CircList []) = Nothing
nextelem (CircList [a]) = Just a
nextelem (CircList (x:xs))= listToMaybe xs
-- 0.1p
previouselem (CircList []) = Nothing
previouselem (CircList [a]) = Just a
previouselem (CircList (x:xs)) = listToMaybe $ reverse xs
-- 0.1p
insert x (CircList a) = CircList $ (x:a)
-- 0.1p
delete n (CircList l) = CircList $ drop n l
-- 0.2p
takefromCL n (CircList []) = []
takefromCL n (CircList l) = take n $ cycle l
-- 0.2p
mvCurrentelem (CircList []) = CircList []
mvCurrentelem (CircList [x]) = CircList [x]
mvCurrentelem (CircList (x:xs)) = CircList $ xs ++ [x]

-- noticing (Eq a) is a requirement!
-- 0.1p
equalCL :: (Eq a) => (CircList a) -> (CircList a) -> Bool
-- 0.3p
equalCL (CircList xs) (CircList ys)
  | length xs /= length ys = False
  | null xs                          = True
  | otherwise                      = or $ map (xs==) (variants ys)

variants xs = take (length xs) (iterate rotate xs)

rotate [] = []
rotate (x:xs) = xs++[x]
-- 0.1p
-- the reason for CircList [1,2,3] /= CircList [1,2,3,1,2,3] is that deletion would not work properly:
-- deleting 3 elems from each would yield an empty list in first case, but non-empty in the second

--=========================================================================================
-- EDAN40
-- Question 1: point-free notation

f = (.) ((5/) .) (+)   -- tricky one (0.6p)
g = flip map . iterate succ -- (0.4p)

-- Question 2: type derivation

($ ($)) :: (((a -> b1) -> a -> b1) -> b2) -> b2
(. (.)) :: (((a -> b) -> a -> c1) -> c2) -> (b -> c1) -> c2
(: (:)) :: TYPE ERROR
(== (==)) :: (Eq a, Eq (a -> a -> Bool)) => (a -> a -> Bool) -> Bool -- but TYPE ERROR also accepted
(|| (||)) :: TYPE ERROR

-- Question 3: proving program properties
{-
It is easy to observe that
fmap id (Just x) = Nothing        
from the definition, while
id (Just x) = Just x
thus the first functor law (fmap id = id) is not fulfilled.
This concludes the proof.
-}

-- Question 4: function composition

-- (a) TRUE  (0.1p)
-- (b) TRUE  (0.1p)
-- (c) FALSE (0.1p)
-- (d) TRUE  (0.1p)
-- (e) TRUE  (0.2p)
-- (f) TRUE  (0.2p)    NOTE: I gave everyone 0.2 here, so the limit for grade 3 was 3.1p this time
-- (g) TRUE  (0.2p)

-- I apologize for the typos in the question text in the (f) and (g) cases

-- Question 5: monadic computations

do "edan40"; [1, 10, 100] :: Num b => [b]
do "edan40"; [1, 10, 100] = [1,10,100,1,10,100,1,10,100,1,10,100,1,10,100,1,10,100]

-- Question 6: language

-- it means they always take only one argument

