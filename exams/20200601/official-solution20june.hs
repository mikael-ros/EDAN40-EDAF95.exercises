{-
 - These are the official solution, adapted from the file provided by Malec. It is appended here for ease of use, and is not intended to be any kind of infringement. If you object to this use, Malec, please feel free to contact me, and I will remove it promptly! :)
 -
 -}

---------------------------------------------------------------------

-- 1
(0.4p) f = flip $ (flip (/)).(5-)
(0.6p) g = flip $ (flip map) . (flip takeWhile $ iterate (+4) 3) . (>=)

--------

-- 2
(0.25) seq, pseq, par ;; a -> b -> b
(0.25) seq: evaluates 1st arg to WHNF, returns the second (immediately)
(0.25) par: evaulates 1st arg to WHNF in parallel (creating a spark) with evaluating the 2nd arg
(0.25) pseq: evaluates the 1st arg (up to WHNF) and only THEN returns the second

--------
-- 3
(0.2p each)

-- .1
:: (a->b,a) -> b
takes a pair: (funtion, argument) and returns the result of applying this function to the argument

-- .2
:: (a,[a]) -> [a]
takes a pair (elem::a, list::[a]) and returns the list with elem inserted at the front

-- .3
:: (b->c,a->b) -> a -> c
takes a pair of functions (suitably typed) and returns their composition

-- .4
:: (a->b->c, (a,b)) -> c
takes the pair (2-arg function in curried form, pair of arguments) and returns the result of applying the function consecutively to the first and second elem of the pair

-- .5
TYPE ERROR

--------

-- 4
Many possibilities here.

A classical example is taking lists and defining fmap as follows:

fmap g [] = []
fmap g (x:xs) = (fmap g xs) ++ [g x]

And showing that the second law does not hold. 

But: almost any function except map will do here (for lists, of course).

--------

-- 5

Here again there is room for creativity. In principle two possibilities:
lists with repetition (check equality!) or without repetition (check insertion, union, etc).
Deriving equality might be an issue in general.

An interesting issue was pointed by a student: sets are not a
functor. But this is not true (at least not completely). There is
positive, trivial answer to this question, below.

Another issue, which I neglect while checking, is that fmap may create duplicates in
a Set, thus effectively shrinking it. In non-repetition implementations this
should be taken care of!

So, an example:

(0.1) data Set a = Set [a]
(0.1) deriving (Eq) somewhere (member is a good place)
(0.1) union (Set xs) (Set ys) = Set $ nub (xs ++ ys)
(0.1) difference (Set xs) (Set ys) = Set (xs \\ ys)
(0.1) intersection (Set xs) (Set ys) = difference (Set xs) (difference (Set xs) (Set ys))
(0.1) cartprod (Set xs) (Set ys) = Set $ [(x,y) | x <- xs, y <- ys]
(0.1) member e (Set xs) = elem  e xs
(0.1) insert e (Set xs) 
          | member e (Set xs) = Set xs
          | Set (e:xs)
(0.2) instance Functor Set where 
          fmap g (Set xs) = Set $ nub $ map g xs



