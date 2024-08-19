# H-99 questions 31-41 :: "Arithmetic"
_as they were on the 18th of August 2024_

## 31
A prime is a prime if it is only divisible by itself and 1. Hence we can simply check if the length of numbers 2 to the number in question (minus one) contain any numbers of which the number is divisible by - wheter the length of ``filter (\n -> p `mod` n == 0)`` is non-zero (``null``). This is equivalent to something like ``all (\n -> p `mod` n /= 0)``, which we can simplify as ``isPrime p = all ((/=) 0 . mod p) [2..pred p]``.

Theres more efficient ways to implement this of course, such as using an algorithm to generate all primes, memoizing it, and checking whether a number is a member of it.

**See the function ``isPrime`` in [``Arithmetic.hs``](Arithmetic.hs)**

## 32
The psuedo code given (for an imperative language) on [Wikipedia](https://en.wikipedia.org/wiki/Euclidean_algorithm) in it's recursive form is written like:

```
function gcd(a, b)
    if b = 0
        return max(a, -a) 
    else
        return gcd(b, a mod b)
```
I will implement this, as it is fairly easy to translate to Haskell. Note that ``max(a, -a)`` can also just be written ``abs a``. I wrote it since thats what Wikipedia suggests.

**See the function ``myGCD`` in [``Arithmetic.hs``](Arithmetic.hs)**

## 33
This ones very simple, just check if ``myGCD`` results in ``1``.

We immediately get ``coprime a b = myGCD a b == 1``, so let's spend some energy attempting to make it point free.

```haskell
coprime a b = myGCD a b == 1
coprime = \a b -> myGCD a b == 1 -- move parameters over
coprime = \a b -> (==) 1 (myGCD a b) -- move operator leftward
coprime = \a -> (((==) 1) . myGCD a) -- remove b
coprime = \a -> (((==) 1 .) (myGCD a))  -- move composition operator to (==) 1, turning it from a function of type Int -> Bool to (Int -> Int) -> Int -> Bool (not exact). To remove a we need to make it's type into (Int -> Int -> Int) -> Int -> Bool, which we can do by composing again
coprime = \a -> (((==) 1 .) . myGCD) a -- apply as discussed above
coprime = (((==) 1 .) . myGCD) -- remove a
coprime = ((==) 1 .) . myGCD -- remove unnecessary parenthesis'
```

**See the function ``coprime`` in [``Arithmetic.hs``](Arithmetic.hs)**

## 34
Just apply ``length`` to the ``filter`` of ``coprime`` on the list ``[1..n-1]``

**See the function ``totient`` in [``Arithmetic.hs``](Arithmetic.hs)**

## 35
The process of calculating these factors is as I remember essentially to find the smallest prime of which evenly divides the number, repetetively until it can no longer be divided successfully. This can be seen as a recursive function that collects factors into an accumulator list, and passes on the quotient to the next step. 

For this we will have to generate a list of primes until the number we are dividing, and grab the first element that gives a rest of 0. I will define a helper function called ``smallestPrimeFactor`` for this purpose.

I will start with the simpler version, which I think will be to use a helper function, then see if I can make a minimal version.

The more minimal version would be:
```haskell
primeFactors' 1 = []
primeFactors' n = smallestPrimeFactor n:primeFactors' (n `div` smallestPrimeFactor n)
```
which we can attempt to make point free like:
```haskell
primeFactors' = \n -> smallestPrimeFactor n:primeFactors' (div n smallestPrimeFactor n) -- move parameter over, and move div over
primeFactors' = \n -> smallestPrimeFactor n:primeFactors' ((div <*> smallestPrimeFactor) n) -- "pass on n"
primeFactors' = \n -> smallestPrimeFactor n:(primeFactors' . (div <*> smallestPrimeFactor)) n -- compose primeFactors
```
which is about as far as I could get with my knowledge (it is possible to make it poinfree)

**See the function ``primeFactors`` in [``Arithmetic.hs``](Arithmetic.hs)**

## 36
Should be as easy as using ``map`` to create a tuple of the quotient and it's multiplicity (length of the filter on the quotient of primeFactors) on every prime factor, after removing duplicates from the list (I'll use ``nub`` from ``Data.List`` for this).

We initially get:

```haskell
primeFactorsMult :: Int -> [(Int, Int)]
primeFactorsMult n = map (\pf -> (pf,length (filter (==pf) pfs))) (nub pfs)
    where pfs = primeFactors n
```

which can be made "simpler" like:

```haskell
primeFactorsMult n = map (\pf -> (pf,length (filter (==pf) (primeFactors n)))) (nub (primeFactors n)) -- remove where to make code easier to reduce
primeFactorsMult = \n -> map (\pf -> (pf,length (filter (==pf) (primeFactors n)))) (nub (primeFactors n)) -- move parameters over
primeFactorsMult = \n -> map (\pf -> (pf,length ((filter (==pf) . primeFactors) n))) ((nub . primeFactors) n) -- compose nub with primeFactors, same for filter
primeFactorsMult = \n -> map (\pf -> (pf,(length . filter (==pf) . primeFactors) n)) ((nub . primeFactors) n) -- compose length with filter blob
```

**See the function ``primeFactorsMult`` in [``Arithmetic.hs``](Arithmetic.hs)**

## 37

This should be as simple as mapping ``\(p,m) -> pred p * p ^ pred m`` or similar over ``primeFactorsMult``, and taking it's product. You can also use a list comprehension for this.

Initially we get:
```haskell
totientImproved :: Int -> Int
totientImproved n = product $ map (\(p,m) -> pred p * p ^ pred m) (primeFactorsMult n)
```
which looks easy to make pointfree:
```haskell
totientImproved = \n -> product $ (map (\(p,m) -> pred p * p ^ pred m) . primeFactorsMult) n -- move n over, and compose map with the pfMult function
totientImproved = product . map (\(p,m) -> pred p * p ^ pred m) . primeFactorsMult -- remove n by also composing product with the rest
```

**See the function ``totientImproved`` in [``Arithmetic.hs``](Arithmetic.hs)**

## 38
Not entirely sure whats meant by the question, I'm probably just dumb...

## 39
Should be as easy as applying ``filter isPrime`` to ``[n..m]``.

So lets also try to make it pointfree. 
```haskell
primesR :: Int -> Int -> [Int]
primesR n m = filter isPrime [n..m]
primesR = \n m -> filter isPrime [n..m] -- move parameters over
primesR = \n m -> filter isPrime (enumFromTo n m) -- replace [n..m] with the function equivalent enumFromTo
primesR = \n m -> ((filter isPrime .) . enumFromTo) n m -- compose twice to handle both arguments
primesR = (filter isPrime .) . enumFromTo -- remove arguments
```

**See the function ``primesR`` in [``Arithmetic.hs``](Arithmetic.hs)**

## 40
We should be able to use a list comprehension to do this, simply fetching the primes up to n twice. This will automatically create the cartesian product of the primes up to n, and we can then just choose to filter the pairs that add up to n.

**See the function ``goldbach`` in [``Arithmetic.hs``](Arithmetic.hs)**

## 41
Should be as simple as mapping ``goldbach`` over a filtered range.

For the other version, we just have to filter for pairs where the first member is above the set floor.

We get:
```haskell
goldbachList :: Int -> Int -> [(Int,Int)]
goldbachList n m = map goldbach (filter even (enumFromTo n m))

goldbachListFloor :: Int -> Int -> Int -> [(Int,Int)]
goldbachListFloor n m f = filter (\p -> fst p > f) (goldbachList n m)
```

Let's first simplify and perhaps make pointfree ``goldbachList``:
```haskell
goldbachList n m = map goldbach (filter even (enumFromTo n m))
goldbachList = \n m ->  map goldbach (filter even (enumFromTo n m)) -- move arguments
goldbachList = \n m ->  map goldbach (((filter even .) .  enumFromTo) n m) -- replace with composition
goldbachList = \n m -> (((map goldbach . filter even) .) . enumFromTo) n m -- compose further
goldbachList = (((map goldbach . filter even) .) . enumFromTo) -- remove arguments
```
and now ``goldbachListFloor``:
```haskell
goldbachListFloor n m f = filter (\p -> fst p > f) (goldbachList n m)
goldbachListFloor = \n m f -> filter (\p -> fst p > f) (goldbachList n m) -- move arguments
goldbachListFloor = \n m f -> filter (\p -> (>) f (fst p)) (goldbachList n m) -- flip comparator and make it a function
goldbachListFloor = \n m f -> filter (\p -> (((>) f) . fst) p) (goldbachList n m) -- partially apply f on >, and compose it with first
goldbachListFloor = \n m f -> filter (((>) f) . fst) (goldbachList n m) -- remove p
goldbachListFloor = \n m f -> ((filter (((>) f) . fst) .) . goldbachList) n m -- compose filter with goldbachList
goldbachListFloor = \f n m -> ((filter (((>) f) . fst) .) . goldbachList) n m -- change order of arguments, because it makes it easier
goldbachListFloor = \f -> ((filter (((>) f) . fst) .) . goldbachList) -- remove n and m
```
Wasn't able to easily make it pointfree, but atleast eliminated two parameters

**See the functions ``goldbachList`` and ``goldbachListFloor`` in [``Arithmetic.hs``](Arithmetic.hs)**