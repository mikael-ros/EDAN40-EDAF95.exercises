# [Exam 2023-06-01](https://fileadmin.cs.lth.se/cs/Education/EDAN40/exams/edan40_230601.pdf) - attempted 2024-08-21
## 1
### ``f x y``
Let's start by inferring the type of ``f``. As it is a simple function, we can immediately see that it takes two numbers, and provides a fractional back. Fractional itself is an extension of Num, so we can constrain the type as ``Fractional a``, which gives ``f :: Fractional a => a -> a -> a`.

Let's now go through the process. 
```haskell
-- Original function
f x y = 5 / (x + y)
-- Move arguments over
f = \x y -> 5 / (x + y) 
-- Make operators into functions
f = \x y -> (/) 5 ((+) x y)
-- Create the partially applied function (/) 5 
f = \x y -> ((/) 5) ((+) x y)
-- (/) 5 is of the type Fractional a => a -> a now
-- and ((+) x y) is of the type Num a => a, whereas (+) itself is Num a => a -> a -> a
-- but we could create the partially applied function (+) x which has the type Num a => a -> a, matching that of (/) 5.
-- that would allow us to create a composition, and isolate y
f = \x y -> ((/) 5 . (+) x) y
-- we can now remove y
f = \x -> (/) 5 . (+) x
-- Let's make . a function (.)
f = \x -> (.) ((/) 5) ((+) x)
-- Let's then create the partially applied function (.) ((/) 5)
f = \x -> ((.) ((/) 5)) ((+) x)
-- Mid exercise sanity check!
-- (.) ((/) 5) has the types
-- (.) :: (b -> c) -> (a -> b) -> b -> c
-- (/) 5 :: Fractional d => d -> d
-- we can then see that
-- b = d
-- c = d
-- giving us (.) ((/) 5) :: Fractional d => (a -> d) -> d -> d
-- (+) x is of type Num e => e -> e
-- which matches and satisfies the type, giving us Fractional d => d -> d -> d
-- so we have so far not fucked anything up! good!
-- lets then create the composition 
f = \x -> (((.) ((/) 5)) . (+)) x
-- and eliminate x
f = ((.) ((/) 5)) . (+)
f = (.) ((.) ((/) 5)) (+)
-- let's also verify this now! the following type variables are unassociated with any prior ones.
-- We have a couple layers of expressions
-- (/) 5 has the type Fractional a => a -> a
-- (.) has the type (c -> d) -> (b -> c) -> b -> d
-- We can assert that
-- c = a
-- d = a
-- so we get ((.) ((/) 5)) :: Fractional a => (b -> a) -> b -> a
-- (.), outer, has the type (f -> g) -> (e -> f) -> e -> g
-- f = (b -> a)
-- g = (b -> a)
-- so we get Fractional a => (e -> (b -> a)) -> e -> (b -> a)
-- = (e -> b -> a) -> e -> b -> a
-- (+) has the type :: Num h => h -> h -> h
-- e = h
-- b = h
-- a = h
-- so we get
-- Fractional h => h -> h -> h
-- Lets forget all other type variables
-- f :: Fractional a => a -> a -> a
-- seems correct, and should compile!
-- lets then just rewrite it a little
-- move operator back
f = ((.) ((/) 5)) . (+)
-- make (/) 5 = 5/
f = ((.) (5/)) . (+)
-- move operator back
f = ((5/) .) . (+)
```

### ``g x y``
``g x y`` is of type ``g :: Num a => a -> (a -> b) -> [b]``, it is equivalent to mapping ``y`` over all the values in ``[x..]``, which will be our first point of extraction.

```haskell
-- Original function
g x y = [y z | z <- [x..]]
-- Move arguments over
g = \x y -> [y z | z <- [x..]]
-- Replace with map
g = \x y -> map y [z | z <- [x..]]
-- Remove redundant comprehension, and replace with generator
g = \x y -> map y [x..]
-- Flip map to get rid of y immediately
g = \x y -> flip map [x..] y
-- Remove y
g = \x -> flip map [x..]
-- Normally I would use enumFromTo here, but seeing as it is not included in the cheat sheet, I will make do with iterate
g = \x -> flip map (iterate succ x)
-- Let's infer the types, so we can see what we are dealing with at this point
-- we currently have one parameter
-- x :: a
-- where a :: Num a
-- lets start with the expression iterate succ x
-- succ :: Num b => b -> b
-- iterate :: (c -> d) -> [d]
-- we can see that
-- b = a
-- c = b
-- d = b
-- so we get:
-- a :: Num a
-- b :: a
-- c :: a
-- d :: a
-- which means iterate succ :: Num a -> a -> [a]
-- lets then process the outer part
-- flip :: (e -> f -> g) -> f -> e -> g
-- map :: (h -> j) -> [h] -> [j]
-- we can see that
-- e = (h -> j)
-- f = [h]
-- g = [j]
-- which means that flip map :: [h] -> (h -> j) -> [j]
-- we can then see that, when supplied with iterate succ x
-- we can see:
-- h = a
-- we get flip map (iterate succ x) :: Num a => (a -> j) -> [j]
-- where that function is what y would have been
-- things look good so far
-- lets add a composition
g = \x -> (flip map . iterate succ) x
-- (.) :: (l -> m) -> (k -> l) -> k -> m
-- l = [a]
-- m = (a -> j) -> [j]
-- k = a 
-- l = [a]
-- gives a function (flip map . iterate succ) :: Num a => a -> (a -> j) -> [j]
-- which we can now simplify as Num a => a -> (a -> b) -> [b]
-- which matches our initial type!
-- lets then remove x
g = flip map . iterate succ
```
## 2
### ``($ ($))``
1. We have no parameters, so no need to assign them any type variables
2. Let's then analyze the expressions, starting from the innermost
    ``($)`` #1 has the type ``:: (a -> b) -> a -> b``
    ``($)`` #2 has the type ``:: (c -> d) -> c -> d``
    The second operator is infix, and is lacking it's supplied function. Since ``$`` is outermost, it's return will be the return of the expression, which will be ``d``.
    From this, we can see that:
    ```haskell
    c :: (a -> b) -> a -> b
    ```
    Which means that ``($)`` #2 actually has the type ``:: (((a -> b) -> a -> b) -> d) -> ((a -> b) -> a -> b) -> d`` 
    
    and the whole expression has the type:

    ``($ ($)):: (((a -> b) -> a -> b) -> d) -> d`` or, if we "reset" the type variables ``($ ($)) :: (((a -> b) -> a -> b) -> c) -> c``
### ``(. (.))``
1. Again, no parameters.
2. Analyze the expressions
    ``(.)`` #1 has the type ``:: (b -> c) -> (a -> b) -> a -> c``
    ``(.)`` #2 has the type ``:: (e -> f) -> (d -> e) -> d -> f``
    Again, one of the operators is infix, so only it's second argument is being supplied, by ``(.)`` #1. The return type will be that of ``(.)`` #2, as it is applied afterward.
    We can then infer that the ``(d -> e)`` part of ``(.)`` #2 is ``(.)`` #1, so we have
    ```haskell
    d :: (b -> c)
    e :: (a -> b) -> a -> c
    ```
    Which means that ``(.)`` #2 will have the type ``:: (((a -> b) -> a -> c) -> f) -> ((b -> c) -> ((a -> b) -> a -> c)) -> (b -> c) -> f``, with the whole expression having the type ``:: ((b -> c) -> ((a -> b) -> a -> c)) -> (b -> c) -> f``.
### ``(: (:))``
``(:)`` #1 has the type ``:: a -> [a] -> [a]``
``(:)`` #2 has the type ``:: b -> [b] -> [b]``
Now, ``(:)`` #2 already has it's second argument occupied by ``(:)`` #1, which means that whatever ``(:)`` #1 is outputting must be of the same type as ``(:)`` #2 second argument.
This means that ``[b] :: a -> [a] -> [a]``, which would generate a type error.

### ``(== (==))``
``(==)`` #1 has ``:: Eq a => a -> a -> Bool``
``(==)`` #2 has ``:: Eq b => b -> b -> Bool``
``(==)`` #2 has it's second argument supplied by ``(==)`` #1, which means that ``b :: Eq a => a -> a -> Bool``.
This gives the entire expression the type ``:: (Eq a,b) => (a -> a -> Bool) -> (a -> a -> Bool) -> Bool``
I am pretty sure this would also generate a type error.

### ``(|| (||))``
``(||)`` #1 and #2 both have the type ``:: Bool -> Bool -> Bool``. There are no type variables to be had. It will also generate a type error, as the other function expects two arguments.

## 3
### ``fmap id = id``
#### Base case
The base case for the ``Maybe`` type is ``Nothing``.
```haskell
fmap id Nothing = Nothing

-- wheras
id Nothing = Nothing

-- both are equal => satisfied
```
#### Inductive case
The only other case is ``Just x``.
```haskell
fmap id (Just x) = Nothing

-- wheras
id (Just x) = Just x
```
As we see, it fails the first rule of ``fmap id = id`` and can as such not satisfy the requirements for ``Functor``. Hence, there is not point to proving the other rule, as we cannot assert this to be a correct implemntation of ``Functor``.

## 4
### (a)
#### Base case
The empty list ``[]`` with n = 0
```haskell
-- left hand side
(map f . take 0) []
= map f []
= []

-- right hand side
(take 0 . map f) []
= take 0 []
= []
-- lhs == rhs => true
```
#### Inductive case
The list ``(x:xs)`` with n = 1
```haskell
-- left hand side
(map f . take 1) (x:xs)
= map f [x]
= [y] -- x -> y

-- right hand side
(take 1 . map f) (x:xs)
= take 1 [y]
= [y]

-- lhs == rhs => true
```
As we see, both cases are true, so this holds true.
### (b)
#### Base case
```haskell
-- left hand side
(map f . reverse) []
= map f []
= []

-- right hand side
(reverse . map f) []
= reverse []
= []
-- lhs == rhs => true
```
#### Inductive case
```haskell
-- left hand side
(map f . reverse) (x:xs)
= map f (xs:x) -- we'll just pretend this syntax is correct lol
= (ys:y)

-- right hand side
(reverse . map f) (x:xs)
= reverse (y:ys)
= (ys:y)

-- lhs == rhs => true
```
Both hold true, so it is true.
### (c)


--- 

Gonna have to call it quits here, simply didn't have time to finish this the night before my exam. Everything up til this point seems to have been 90% correct, so I think I'll do alright tomorrow. Wish me luck.

## Points and grade
### With assistance (**)


### Without assistance
I got a total of  points, which I assume is under passing.

## Qualities
### Strengths
- 
### Weaknesses
- 