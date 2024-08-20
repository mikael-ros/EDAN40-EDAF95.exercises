# [Exam 2018-05-28](https://fileadmin.cs.lth.se/cs/Education/EDAN40/exams/edan40_180528.pdf) - attempted 2024-08-19
## 1 **
### Make ``f x y`` pointfree
Let's begin with figuring out what the function does, which in this case is the division of 3 - y with x. This function has the type ``Fractional a => a -> a -> a``, where ``Fractional`` is a restriction of the type ``a``.

```haskell
-- The original function f x y
f x y = (3 - y) / x 
-- We'll move the arguments over to the right, to prepare for further processing
f = \x y -> (3 - y) / x 
-- We can then move y into the paranthesis, as thats where it's being used
f = \x y -> (3 - y) / x
-- We'll make the operators into functions, to move them leftward in preparation of the next step
f = \x y -> (/) ((-) 3 y) x
-- We see now that, if we were able to supply the arguments in reverse order, we could maybe knock of y
-- A way to do that would be to apply flip to /, allowing us to supply x first.
f = \x y -> (flip (/)) x ((-) 3 y)
-- If we then create the partially applied function flip (/) x, we can now further isolate (-) 3 y
f = \x y -> flip (/) x ((-) 3 y)
-- flip (/) x is of type Fractional a => a -> a
-- (-) 3 y is of type Num a => a
-- if we remove y it is (-) 3 :: Num a => a -> a
-- Since they both now take in a Num a and give a Num a, we can compose them
f = \x y -> (flip (/) x . (-) 3) y
-- We can then remove y, as it is now simply being supplied to this inner function
f = \x -> flip (/) x . (-) 3
-- We can now move the composition operator over by making it into a function
f = \x -> (.) (flip (/) x) ((-) 3)
-- We can thereafter flip the composition operator, so we are able to move flip (/) x rightward in preparation
-- of further processing
f = \x -> (flip (.)) ((-) 3) (flip (/) x)
-- We can now partially apply ((-) 3) to flip (.)
f = \x -> (flip (.) ((-) 3)) (flip (/) x)
-- (.) is of type (b -> c) -> (a -> b) -> a -> c
-- which means flip (.) is of type (a -> b) -> (b -> c) -> a -> c
-- One function is already applied, so we currently have (b -> c) -> a -> c
-- flip (/) x is of type Fractional a => a -> a as before
-- so if we want to remove x, we get flip (/), type Fractional a => a -> a -> a
-- flip (.) ((-) 3) . is of type (a -> b -> c) -> a -> b -> c
-- so we can go ahead and compose them, like below
f = \x -> (flip (.) ((-) 3) . flip (/)) x
-- and we can now finally remove x, and change (-) 3 back into the original shape
f = flip (.) (3-) . flip (/)
```

>> Correct, but could be better. + .5p (= .5p)

### Make ``g x y`` pointfree
``g`` seems to be a function that applies a function ``x`` to all elements of a list ``[1,3..y]`` of integers. The type of ``g`` is hence: ``g :: (Int -> a) -> Int -> [a]``.

```haskell
-- Original function
g x y = [x z | z <- [1,3..y]]
-- Move over parameters as lambda function
g = \x y -> [x z | z <- [1,3..y]]
-- Change application of x to a map over the list comprehension
g = \x y -> map x [z | z <- [1,3..y]]
-- Remove reduntant comprehension
g = \x y -> map x [1,3..y]
-- Here I would replace the generator with something like enumFromTo, but this is not included in the cheatsheet
-- We can instead use iterate, which is a function that applies a function to a value recursively, saving every step
-- Since we start at 3, we'll have to prepend 1 to something like take y (iterate (+1) 3)
g = \x y -> map x (1:(take y (iterate (+1) 3)))
-- We'll then want to flip take, to move y further to the right
g = \x y -> map x (1:((flip take) (iterate (+1) 3) y))
-- We can then partially apply iterate (+1) 3 to flip take, and remove unnecessary parenthesis
g = \x y -> map x (1:(flip take (iterate (+1) 3)) y)
-- We can then create the partially applied function as seen
g = \x y -> map x (((1:) . flip take (iterate (+1) 3)) y)
-- map is of type (a -> b) -> [a] -> [b]
-- flip take is of type [a] -> Int -> [a]
-- -- iterate (+1) 3 is of type [Int]
-- -- 1: is of type [Int] -> [Int]
-- which means flip take (iterate (+1) 3) is of type Int -> [Int]
-- and (1:flip take (iterate (+1) 3)) is of type Int -> [Int]
-- so we should safely be able to compose map x with the rest, and remove y
g = \x -> map x . (1:) . flip take (iterate (+1) 3)
-- Now we can move . over to the left by making it a function
g = \x -> (.) (map x) ((1:) . flip take (iterate (+1) 3))
-- Then we can flip it
g = \x -> (flip (.)) ((1:) . flip take (iterate (+1) 3)) (map x)
-- Create the partially applied function as seen below
g = \x -> (flip (.) $ (1:) . flip take (iterate (+1) 3)) (map x)
-- Compose and get lucky!
g = flip (.) ((1:) . flip take (iterate (+1) 3)) . map
```

I realized after doing all this that the ``[1,3..y]`` actually defines an odd pattern, oops. Oh well. I did what I believed the function did and still made it pointfree, so I'm gonna count it anyway. Wrong idea, right execution I guess...

>> Correct, even if misunderstood. + .5p (= 1p)

## 2
### (a)
``(.)`` is of type ``(b -> c) -> (a -> b) -> a -> c``

``(:)`` is of type ``a -> [a] -> [a]``

Considering that ``.`` is in it's function form, it is being partially applied with the function ``(:)``, which gives us the type ``(a -> b) -> a -> c``, or specifically here ``(a -> b) -> a -> [b] -> [b]``

>> Correct. + .2p (= 1.2p)

### (b) **
Now we are partially applying ``(.)`` to ``(:)`` which will give the type ``[(b -> c) -> (a -> b) -> a -> c] -> [(b -> c) -> (a -> b) -> a -> c]``

>> Correct. + .2p (= 1.4p)

### (c)
We are here seeing ``:`` in it's normal infix operator form. This is equivalent to ``((:)(.))`` from the prior question and will have the same type.

>> Correct. + .2p (= 1.6p)

### (d) 
This is equivalent to ``((flip (:))(.))``. 

``flip (:)`` is of type ``[a] -> a -> [a]``, which won't be able to accept the function ``(.)``, as ``(.)`` is not a list. This will generate a type error.

>> Correct. + .2p (= 1.8p)

### (e)
We are generating an empty list ``[]``, passing it onto (I think) the lambda function ``\_ -> [(>=)]`` which will throw away any list members passed onto it (of which there are none) and generate a list with the function ``>=``, which is of type ``Ord a => a -> a -> Bool`` 

So, that inner lambda function is of type ``Ord b => a -> [b -> b -> Bool]``.

A look at the cheatsheet reveals that the instance of ``Monad`` on ``[]`` is defined as ``xs >>= f = concat (map f xs)``.
``concat`` is of the type ``[[a]] -> [a]``, ``map f xs`` gives ``[b]``, where b in this case would be ``[b -> b -> Bool]``. As such, ``concat`` will itself return ``[b -> b -> Bool]`` too, giving the whole function the type ``Ord b => [b -> b -> Bool]``, or more aptly now that ``a`` is gone ``Ord a => [a -> a -> Bool]``.

>> Correct. + .2p (= 2p)

## 3
We can prove it by computing it step by step.

For ``fmap id = id``
```haskell
    fmap id [] = [] -- 1. fmap application
    id [] = [] -- 2. id behaviour
    -- 1 == 2, rule is satisfied

    fmap id (x:xs) = id x : (fmap id xs) -- 1. fmap application
    = id x : (id x2 : (fmap id x2s)) -- and so on, we see that we apply it to every item now
    = ...
    = (x:xs)
    id (x:xs) = (x:xs) -- 2. id behaviour
    -- 1 == 2, rule is satisfied here too
```

For ``fmap (p . q) = (fmap p) . (fmap q)``
```haskell
    fmap (p . q) [] = [] -- 1. left hand side
    (fmap p) . (fmap q) [] -- 2. right hand side
    = fmap p (fmap q []) 
    = fmap p ([])
    = fmap p []
    = [] 
    -- 1 == 2, rule satisified

    fmap (p . q) (x:xs) = (p . q) x : (fmap (p . q) xs) -- 1. left hand side
    = (p . q) x : ((p . q) x2 : (fmap (p . q) x2s)) -- and so on
    (fmap p) . (fmap q) (x:xs) -- 2. right hand side
    = fmap p (fmap q (x:xs))
    = p (head (fmap q (x:xs))) : (fmap p (tail (fmap q (x:xs)))) -- and so forth
    -- we see that the function q will be applied to every element before p, and is as such equivalent with p . q
    -- 1 == 2, rule satisfied
```

As we can see, all rules are satisfied, so the definition is correct.

>> Correct ?. + 1p (= 3p)

## 4 **
This is an uncurried function accepting a tuple of a list and a function, and returning a new list.

One such use case could be a mapping function, which is what we would get if we curried and flipped this function. Hence we can simply define a function that **flips then uncurries** map, and we would get this type signature, like:

``sillyMap = uncurry . flip $ map``

>> Correct. + 1p (= 4p)


## 5
To be of an ordered type, an instance needs to implement (atleast some of) ``>``, ``<``, ``>=``, ``<=``, ``compare``, ``min``, and ``max``. The minimal implementation is ``<=`` or ``compare``

```haskell
    instance (Ord a, Ord b) => Ord (a,b) where
        (<=) (a,b) (c,d) = a <= b && c <= d 
```

```haskell
    instance Ord b => Ord [b] where
        (<=) a b = length a <= length b
```

>> Incorrect. + 0p (= 4p)

## 6
### (a) **
``f`` takes in two parameters ``x`` and ``y``, which get multiplied. This places the restriction of ``Num`` on both of them, to allow the ``*`` operation. Hence, the type of ``f`` is presumably ``Num a => a -> a -> a``. But! since we are in ``do`` notation, we are in ``Monad`` land. Hence all the numbers are allowed "not to exist", and are hence wrapped as Monads. The type should then be ``(Monad m, Num a) => m a -> m a -> m a``.

>> Correct. + .1p (= 4.1p)

### (b) **
Since we are essentially creating a list comprehension, the values will be the result of ``map (\(a,b) -> a * b)`` on the cartesian product of ``[1,2,3]`` and ``[2,4,8]``. The cartesian product of them is ``[(1,2),(1,4),(1,8),(2,2),(2,4),(2,8),(3,2),(3,4),(3,8)]`` which should yield ``[2,4,8,4,8,16,6,12,24]``

>> Correct. + .2p (= 4.3p)

### (c)
The value will be ``Nothing``, as it will terminate after evaluating ``b <- y``.

>> Correct. + .1p (= 4.4p)

### (d) **
``(Monad m, Num a) => m a``

>> Correct. + .1p (= 4.5p)

### (e) **
The function phases from ``[Int]`` to ``[a]`` to ``[Char]``, but nothing is returned, so we get ``""``.

>> Correct. + .25p (= 4.75p)

### (f)
Now we return something, so we should get ``"abc"``

>> Correct. + .25p (= 5p)

--- 

### With assistance (**)
Total 5p out of 6p possible points. Not sure what this equates to on the grading scale. Maybe about grade **``4``**?.

### Without assistance
If removing points from tasks where I had to jog my mind with other resources that would not have been available during a real exam (marked with **), I would have a total of (5-0.25-0.1-0.2-0.1-1-0.2-1)p = 5 - 2.85 p = 2.15p, which is not good enough and presumably below passing.
