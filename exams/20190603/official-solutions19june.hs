{-
 - This is the official solution document provided by Malec. It is appended here for ease of use, and is not intended to be any kind of infringement. If you object to this use, Malec, please feel free to contact me, and I will remove it promptly! :)
 -
 -}

---------------------------------------------------------------------
-- EDAF40
----------------------------------------------
-- 1.
zipWith map :: [a -> b] -> [[a]] -> [[b]]
-- takes a list of functions and a list of lists and applies functions to lists, one by one
map zipWith :: [a -> b -> c] -> [[a] -> [b] -> [c]]
-- takes a list of two-argument functions and yields a list of instances of specific (concretized) zipping functions
map . zipWith :: (a -> b -> c) -> [[a]] -> [[b] -> [c]]
-- takes a (zipping) function and a list of second arguments for map (i.e. lists), yielding a list of partially applied zipWiths waiting for the second argument (i.e. a list)

-- 2.
insertat what xs pos = (take pos xs) ++ [what] ++ (drop pos xs)
inserteverywhere what xs = map (insertat what xs) (enumFromTo 0 (length xs))
permutations [] = []
permutations (x:xs)
  | (length xs) == 0 = [[x]]
  | otherwise = concat $ map (inserteverywhere x) (permutations xs)
  
-- 3.
myfilter list = [tail x | x <- list, not (null x), odd (head x)]
myfilter2 list = map tail $ filter (odd. head) $ filter (not . null) list

-- 4.
-- nothing

-- 5.
oneOf False False True = True
oneOf False True False = True
oneOf True False False = True
oneOf _ _ _ = False

-- 6.
eliminatem :: a -> [b] -> Grid -> Maybe Grid
eliminatem :: a -> [b] -> Grid -> [Grid]
-- YES, just different instance of monadic type

----------------------------------------------
--EDAN40
----------------------------------------------
-- 1.
-- YES
--
-- first law: fmap id = id
-- As fmap g [] = [] then fmap id [] = [] = id [] (inductive base case)
-- Assume that fmap id xs = id xs (inductive assumption)
-- As fmap g (x:xs) = [g x] ++ (fmap g xs) then fmap id (x:xs) = [id x] ++ (fmap id xs) = [id x] ++ (id xs) = [x] ++ xs = x:xs = id (x:xs)
-- QED
--
-- second law: fmap (p . q) = (fmap p) . (fmap q)
-- base case: fmap (p . q) [] = []
-- (fmap p) . (fmap q) [] = (fmap p) ((fmap q) []) = (fmap p) (fmap q []) = (fmap p) [] = fmap p [] = []
-- Assume fmap (p . q) xs = ((fmap p) . (fmap q)) xs (inductive assumption)
-- Then fmap (p . q) (x:xs) = [(p . q) x] ++ (fmap (p . q) xs) = [(p . q) x] ++ ((fmap p) . (fmap q)) xs (induction)
-- But ((fmap p) . (fmap q)) (x:xs) = (fmap p) ((fmap q) (x:xs)) = (fmap p) ([q x] ++ (fmap q xs)) = (fmap p) ((q x) : (fmap q xs)) = [p (q x)] ++ (fmap p)(fmap q xs) = [(p . q) x] ++ ((fmap p) . (fmap q)) xs
-- QED

-- 2.
data Tree3String = Leaf String | Node String Tree3String Tree3String Tree3String

data Tree3 a = Leaf a | Node a (Tree3 a) (Tree3 a) (Tree3 a) 

instance Functor Tree3 where
  fmap g (Leaf x) = Leaf (g x)
  fmap g (Node d x y z) = Node (g d) (fmap g x) (fmap g y) (fmap g z)
  
instance (Eq a) => Eq (Tree3 a) where
  (==) (Leaf x) (Leaf y) = (x == y)
  (==) (Node d1 x1 y1 z1) (Node d2 x2 y2 z2) = (d1 == d2) && (x1 == x2) && (y1 == y2) && (z1 == z2)
  (==) _ _ = False
  
-- 3.
f =  flip $ (*) . (3-)
g = flip ((flip map) . (filter (<3)))

-- 4.
-- because par and pseq enforce evaluation only to the WHNF, i.e. the head  of lists lesser and greater, yielding no useful paralellisation
-- what is missing is "force" evaluating the whole spine of a list

-- 5.
assignment :: Parser Statement
word :: Parser String
accept :: String -> Parser String
Expr.parse :: Parser Expression
require :: String -> Parser String
buildAss :: (String, Expression) -> Statement
Assignment :: String -> Expression -> Statement
(#-) :: Parser a -> Parser b -> Parser a
(#) :: Parser a -> Parser b -> Parser (a,b)
(>->) :: Parser a -> (a -> b) -> Parser b

-- probably not completely correct, untested version, but definitely satisfactory
assignment input = do
                       (var , rest1 ) <- word input
		       (foo, rest2) <- accept ":=" rest1
		       (val, rest3) <- Expr.parse rest2
		       (bar, rest4) <- require ";" rest3
		       return (bldAss (var, val)) rest4
