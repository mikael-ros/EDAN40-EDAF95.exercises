{-
 - This is the official solution document provided by Malec. It is appended here for ease of use, and is not intended to be any kind of infringement. If you object to this use, Malec, please feel free to contact me, and I will remove it promptly! :)
 -
 -}

---------------------------------------------------------------------

-- Solution suggestions for examss in functional programming, 2022.06.02, JM

-- EDAF95

-- 1. permutations

-- variant A. almost correct solution (diverging on [])
perms1 :: (Eq a) => [a] -> [[a]]
perms1 [] = [[]] 
perms1 list = [x:xs | x <- list , xs <- perms1 (delete x list)]

-- variant B. a possible completely correct solution
insertAt :: a -> [a] -> Int -> [a]
insertAt x list pos = (take pos list) ++ [x] ++ (drop pos list)

insertEverywhere :: a -> [a] -> [[a]]
insertEverywhere x list = map (insertAt x list) (enumFromTo 0 (length list))

perms :: [a] -> [[a]]
perms [] = []
perms [x] = [[x]]
perms (x:xs) = concat $ map (insertEverywhere x) (perms xs)

-- 2. type derivation
-- 2a. (0.4p)
g :: [Int] -> [[Char]]
-- 2b. (0.3p)
curry curry :: TYPE ERROR
-- 2c. (0.3p)
curry . curry :: (((a, b1), b2) -> c) -> a -> b1 -> b2 -> c

-- 3. List comprehension
g list = [tail x | x <- list, not (null x), odd (head x)]
g2 list = map tail $ filter (odd. head) $ filter (not . null) list
-- note you cannot freely drop the arg in g2. I did not expect the point-free version!

-- 4. Binding
"Ukraine" >>= (\u -> flip (:) [] $ id u) :: [Char]

(\u -> flip (:) [] $ id u) =
(\u -> flip (:) [] u) =
(\u -> (:) u []) =
(\u ->[u])

-- As the first arg to >>= is a list (String) then we deal with the list monad,
-- so binding amount to performing concatmap on its input, thus
--"Ukraine" is split in letters, subjected each to (\u ->[u])
-- giving values ['U'], ['k'], ['r'], ['a'], ['i'], ['n'], ['e']
-- finally concatenated back to "Ukraine"

-- 5. Relations
-- we assume that sets are represented as lists
-- things can be simplified by smart use of nub here and there

data Relation a b = Relation [(a,b)] deriving Show
-- the two below are not needed, just examples
emptyrel s1 s2 = Relation []
totalrel s1 s2 = Relation [(x,y)|x <- s1,y <- s2]

unionR :: (Eq a, Eq b) => Relation a b -> Relation a b -> Relation a b
unionR (Relation l1) (Relation l2) = Relation $ union l1 l2

intersectionR :: (Eq a, Eq b) => Relation a b -> Relation a b -> Relation a b
intersectionR (Relation l1) (Relation l2) = Relation $ intersect l1 l2

composition :: (Eq a, Eq b, Eq c) => Relation b c -> Relation a b -> Relation a c
composition (Relation r1) (Relation r2) = Relation [(x,z) | (x,y1) <- r2, (y2,z) <- r1, y1 == y2]

equalR :: (Eq a, Eq b) => Relation a b -> Relation a b -> Bool
equalR (Relation r1) (Relation r2) = subrel (Relation r1) (Relation r2) &&
                                     subrel (Relation r2) (Relation r1)
-- just to make sure that order of elements does not matter

subrel :: (Eq a, Eq b) => Relation a b -> Relation a b -> Bool
subrel (Relation r1) (Relation r2) = all ((flip elem) r2) r1
-- or simply subset

closure :: (Eq a) => Relation a a -> Relation a a
-- my explanation was quite clumsy
-- it should be: closure R = R union R . R union R . R . R union R . R . R . R union ...
-- (in finite cases: until it saturates)
-- in our definition we assume that the relation is finite
closure (Relation r)
  | equalR (Relation r) (unionR (Relation r) (composition (Relation r) (Relation r))) = Relation r
  | otherwise = closure (unionR (Relation r) (composition (Relation r) (Relation r)))


-- EDAN40

-- 1. type derivation

-- a. (0.3p)
elem :: (Eq a) => a -> [a] -> Bool
flip :: (a -> b -> c) -> b -> a -> c
not :: Bool -> Bool
filter :: (a -> Bool) -> [a] -> [a]
toLower :: Char -> Char
map :: (a -> b) -> [a] -> [b]
words :: String -> [String]
reduce :: a -> a

prepare = reduce . words . map toLower . filter (not . flip elem ".,:;*!#%&|")

--thus
elem :: a -> [a] -> Bool
flip elem :: [a] -> a -> Bool
flip elem ".,:;*!#%&|" :: Char -> Bool
(not . flip elem ".,:;*!#%&|") :: Char -> Bool
filter (not . flip elem ".,:;*!#%&|") :: [Char] -> [Char]
filter (not . flip elem ".,:;*!#%&|") :: String -> String
map toLower :: String -> String
map toLower . filter (not . flip elem ".,:;*!#%&|") :: String -> String
words . map toLower . filter (not . flip elem ".,:;*!#%&|") :: String -> [String]
reduce . words . map toLower . filter (not . flip elem ".,:;*!#%&|") :: String -> [String]

--thus
prepare :: String -> [String]

-- b. (0.4p)
map2 :: (a -> b, c -> d) -> (a, c) -> (b, d)
map :: (a -> b) -> [a] -> [b]
words :: String -> [String]
toLower :: Char -> Char

rulesCompile :: [(String, [String])] -> e
-- note renaming, to avoid confusion with b above
rulesCompile = (map . map2) (words . map toLower, map words)

--thus
map toLower :: String -> String
words . map toLower :: String -> [String]
map words :: [String] -> [[String]]
(words . map toLower, map words) :: (String -> [String] , [String] -> [[String]])
map2 :: (a -> b, c -> d) -> (a, c) -> (b, d)
map :: (a -> b) -> [a] -> [b]
map . map2 :: (a -> b, c -> d) -> [(a, c)] -> [(b, d)]
(map . map2) (words . map toLower, map words) :: [(String , [String])] -> [([String] , [[String]])]

-- thus e is
[( [String] , [[String]] )]

-- c. (0.3p)
transformationApply :: Eq a => a -> ([a] -> [a]) -> [a] -> ([a], [a]) -> Maybe [a]
orElse :: Maybe a -> Maybe a -> Maybe a
foldr1 ::  (a -> a -> a) -> [ a ] -> a

-- thus
transformationApply ::  a -> ([a] -> [a]) -> [a] -> ([a], [a]) -> Maybe [a]
transformationApply wildcard :: ([a] -> [a]) -> [a] -> ([a], [a]) -> Maybe [a]
transformationApply wildcard f :: [a] -> ([a], [a]) -> Maybe [a]
transformationApply wildcard f x ::  ([a], [a]) -> Maybe [a]
(transformationApply wildcard f x) ::  ([a], [a]) -> Maybe [a]
map (transformationApply wildcard f x) ::  [ ([a], [a]) ] -> [ Maybe [a] ]

--thus
pats :: [ ([a], [a]) ] 
(map (transformationApply wildcard f x) pats) :: [ Maybe [a] ]

foldr1 ::  (a -> a -> a) -> [ a ] -> a
foldr1 orElse :: [ Maybe b ] -> Maybe b

-- putting it all together
foldr1 orElse (map (transformationApply wildcard f x) pats) :: Maybe [a]

-- 2. Proving properties (2p) (I realize it was too easy for 2p:-)

--Yes, the (Either a) functor is correctly defined.
{-- A proof

Functor laws:
L1: fmap id = id
L2: fmap (p . q) = (fmap p) . (fmap q)

our definition:
fmap f (Right x) = Right (f x)
fmap f (Left x)  = Left x

Let us prove the laws. We need always two cases. We begin with L1.

fmap id (Right x) = Right (id x) = Right x = id (Right x)
fmap id (Left x) = Left x = id (Left x)

Thus L1 holds. Let's look at L2.

fmap (p . q) (Right x) = Right ((p . q) x) = Right (p (q x)) = fmap p (Right (q x)) = (fmap p) $ fmap q (Right x) = (fmap p) . (fmap q) (Right x)
fmap (p . q) (Left x) = Left x = fmap p $ Left x = fmap p $ fmap q $ Left x = (fmap p) . (fmap q) (Left x)

Thus L2 holds as well, meaning that our fmap fulfills both L1 and L2 and the instance is correctly defined.
--}

-- 3. Sparks (1p)
-- a spark is a possibility to create a thread
-- it occurs whenever a (reasonable according to the compiler) possibility of parallelisation occurs
-- it may be induced by use of par

-- 4. Programming (1p)

type Image a = Position -> a
type Position = (Float,Float)
type Region = Image Bool
-- in the text there is wrong type: Boolean, but only one person recognized the issue:-)

-- a. (0.4p)
paste :: Region -> Image a -> Image a -> Image a
paste reg im1 im2 = (\p -> if (reg p) then (im1 p) else (im2 p))

-- b. (0.4p)
lift0 :: a -> Image a
lift1 :: (a -> b) -> Image a -> Image b
lift2 :: (a -> b -> c) -> Image a -> Image b -> Image c

lift0 x = (\p -> x)
lift1 f im = (\p -> f (im p))
lift2 f im1 im2 = (\p -> f (im1 p) (im2 p))

-- c. (0.2p)
-- ANS: One would need to make im1 and im2 belong to an instance of a numeric type
-- In other words: make Image a, for a being instance of Num, an instance of Num

-- Note1: might be quite complicated...
-- Note2: another possibility would be to redefine (-), but this would be even more complicated
-- Note3: Image would need to be a true type, not just a synonym

-- 5. Monadic computations
e k = do
      x <- k
      Nothing
      return 42

-- type: as Nothing occurs as one of the elements of do, the monad must be a Maybe something
-- as return is applied to 42, this something must be an instance of Num
-- as e takes an argument, it is a function
-- thus:

e :: Num b => Maybe a -> Maybe b

-- and the value of e applied to any Maybe value (like Just "me", or Just 42) is
e (Just "me") = Nothing
-- because of the middle element of the do block: Nothing bound with whatever is always Nothing!

