# [Exam 2017-06-02](https://fileadmin.cs.lth.se/cs/Education/EDAN40/exams/edan40_170602.pdf) - attempted 2024-08-20
## 1
### Complete ``Num MyNatural``
We need to define ``(+)``, ``(-)``, ``(*)``, as well as ``negate``, ``abs``, and ``signum``, along with ``fromInteger``.

As can be seen in the type class definition, ``Num`` is an extension of ``Eq`` and ``Show``, so ``MyNatural`` also needs to implement those instances. It does so by deriving them in this case, so we do not need to worry about implementing them.

Our numeric type seems to count by adding units, and ending with an ``Empty``, which is itself also a ``MyNatural``. It's honestly a little funky looking, but okay!

Let's just go through and get an understanding of the defined functions.

#### ``f1``
``f1`` seems to apply a function to the second part of ``MyNatural``, denoted by ``x``. If ``x`` turns out to be ``Empty``, then we just return ``y`` and return ``() :-: y``, if it isn't, we keep going until it is. We are climbing through the numbers until we reach the end, and assigning ``y`` to the end. ``y`` has to be a ``MyNatural`` for this to work. 

Since ``y`` can be of any length of it's own, this operation looks a lot like addition.

The type is therefore ``f1 :: MyNatural -> MyNatural -> MyNatural``

#### ``f2``
I'm not fully sure what this function does. I think it multiplies two numbers? Because it has to execute it y times, x times.

```haskell
f2 (() :-: x) y = f1 y (f2 x y)
= () :-: (f1 y2 (f2 x y))
= () :-: () :-: (f1 y3 (f2 x y))
= ...
= () :-: () :-: () :-: (f1 Empty (f2 x y))
= () :-: () :-: () :-: f2 x y
= f1 y (f2 x2 y)
= ... 
= f1 y (f2 Empty y)
= ...
= () :-: () :-: () :-: () :-: () :-: () :-: () :-: Empty -- or similar
```

#### ``f3``
This function should be subtraction, as we get "count down" (by "cutting off it's tail") the first argument until the second reaches ``Empty``. We can think of it as "exhausting" y. If x becomes exhausted before y, we are heading into negative numbers territory, hence the error (we are are only defining the positive number space so)

```haskell
f3 (() :-: x) (() :-: y) = f3 x y
= (() :-: x2) (() :-: y2) 
= ...
{- case 1 -} = (() :-: Empty) (() :-: yN) -- x smaller than y
             = Empty yN = error "foo"
{- case 2 -} = (() :-: xN) (() :-: Empty) -- y smaller than x
             = xN Empty = xN
{- case 3 -} = (() :-: Empty) (() :-: Empty) -- x equals y
             = Empty Empty = error "foo"
```

#### Let's define it
The first three should be simple, as they have been defined for us. ``abs`` is also simple, as we don't have any negative numbers. ``negate`` should yield an error on anything other than ``Empty``

```haskell
instance Num MyNatural where
(+) = f1
(-) = f3
(*) = f2
abs = id
negate Empty = id
negate _ = error "bar"
```
``signum`` can also only ever be positive or zero, so we can define it as ``Empty`` when zero and ``()`` when not.

```haskell
signum Empty = Empty
signum _ = () :-: Empty
```

``fromInteger`` will have to give an error when negative numbers are given, and otherwise recursively construct a ``MyNatural``
```haskell
fromInteger n | n < 0 = error "baz" -- covers the negative case
fromInteger n = () :-: (fromInteger (pred n))
```

#### Prove that this definition satisfies ``(abs x) * (signum x)``
For ``x = Empty`` (x = 0) (base case)
```haskell
(abs x) * (signum x)
= f1 (signum x) (f2 Empty (signum x))
= f1 Empty (f2 Empty (signum x))
= f2 Empty (signum x)
= Empty
= x
```

For ``x = () :-: x2`` (a large number) (inductive step)
```haskell
(abs x) * (signum x)
= f1 (signum x) (f2 x2 (signum x))
= () :-: (f1 Empty (f2 x2 (signum x)))
= () :-: (f2 x2 (signum x)) -- f1 Empty y = y
= () :-: (f1 (signum x) (f2 x3 (signum x)))
= ... -- f1 (signum x) produces one unit per step
= () :-: () :-: ... :-: (f1 (signum x) (f2 xN (signum (x))))
= () :-: () :-: ... :-: () :-: f2 Empty (signum x)
= () :-: () :-: ... :-: () :-: Empty
= x
```

>> Almost correct, just missed the case fromInteger 0, giving full points anyway as I don't think I would have missed that in a real exam +1p (= 1p)

## 2 
### (a)
The first version, as the second one never accesses the table, and is as such not memoized.
>> Correct. +.5p (= 1.5p)

### (b)
Because of memoization. The first version saves all the answers to each recursive step, readily accessible when retrieved, whereas the second has to recompute it not only when retrieved but for every single recursive step. This effect worsens with larger data structures, where memoization would otherwise shine. 
>> Correct. +.5p (= 2p)

## 3
### (a)
Let's rewrite it as ``iterate = (.) unfoldr g`` for clarity.

The ``(.)`` function has the type ``(.) :: (b -> c) -> (a -> b) -> a -> c``. Partially applied with ``unfoldr``, it becomes something like ``(a -> b) -> a -> c``. 
``unfoldr`` has the type ``(b -> Maybe (a,b)) -> b -> [a]``. For the composition to be valid, it is then imperative that the type ``b`` is whats being referred to as type ``(b -> Maybe (a,b)) -> b`` in the ``unfoldr`` type declaration. ``g`` should therefore be of the type ``a -> (b -> Maybe (a,b)) -> b``

I am very unsure about this however.

>> Incorrect. +0p (= 2p)

### (b)
```haskell
g :: a -> (b -> Maybe (a,b)) -> b
g a f = Just snd $ f a
```  

Not sure about this either.

>> Incorrect. +0p (= 2p)

## 4
Let's first prove the first rule.

### ``fmap id = id``
#### Base case
```haskell
-- 1
fmap id []
= []

-- 2
id []
= []

-- 1 == 2
```
This proves to be true.
#### Induction
```haskell
-- 1
fmap id (x:xs)
= fmap id xs ++ [id x]
= fmap id x2s ++ [id x2] ++ [x]
= fmap id x3s ++ [id x3] ++ [x2] ++ [x]
...
= [xN, xN-1, ..., x2, x] -- the reverse of the list

-- 2
id (x:xs) = (x:xs)

-- 1 != 2
```
The inductive step proves false, hence the first rule is not satisfied, and there is no point proving the other rule as this definition of a ``Functor`` is now as good as invalid.

>> Correct. +1p (= 3p)

## 5
A spark is a "potential thread", what you could call a Haskell level thread. It only becomes an actual thread when it's necessary, and will otherwise remain sequential.

``seq`` forces a layer of evaluation. ``pseq`` forces OS level threading, whereas ``par`` creates a spark. ``pseq`` evaluates the first argument and only then the second argument, whereas ``par`` allows them to be evaluated parallell to eachother. ``par`` however only creates a spark, as mentioned, as it might be able to execute the same way as ``pseq`` if "lucky"

>> Incorrect. Almost correct though, kind of mixed up the terms a little. +0p (= 3p)

## 6
### (a)
Let's begin by making the middle composition operator a function ``(.)``:

``(.) (.) (.)``

As seen now, this is simply the composition of the composition function with itself. 

Now, all three of these have the type ``(.) :: (b -> c) -> (a -> b) -> a -> c``, which means we should get the type ``((b1 -> c1) -> (a1 -> b1) -> a1 -> c1) -> ((b2 -> c2) -> (a2 -> b2) -> a2 -> c2) -> ?``

Don't know..

### (b)
Don't know how to do this to be frank.
### (c)
Same here.
>> Incorrect. Didn't finish +0p (= 3p)
--- 
## Points and grade
### With assistance (**)
Used no assistance this time.

### Without assistance
I got a total of 3 points, which I assume is under passing.

## Qualities
### Strengths
- proving Functor instances
- implementing instances
- parallelization, to a degree, but needs work
- memoization
### Weaknesses
- pseq vs seq
- type derivation