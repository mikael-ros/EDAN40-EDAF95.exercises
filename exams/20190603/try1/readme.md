> This attempt is a throwaway. It went horribly, so ignore this. 
---
# [Exam 2019-06-03](https://fileadmin.cs.lth.se/cs/Education/EDAN40/exams/edan40_190603.pdf)
## 1
### Prove the instance of Functor
The easiest way to "prove" this, is evaluating the rules one by one.

For ``fmap id = id``:
```haskell
    fmap id []
    = []
```
and
```haskell
    fmap id (x:xs)
    = [id x] ++ (fmap id xs)
    = x ++ ([id x2] ++ (fmap id x2s))
```
As we quickly see the list iterates through each element without changing it, reassembling the list in order as it goes on.

This matches the behaviour desired, as there is no change in the input to the output - like the identity function is supposed to behave like.

For ``fmap (p . q) = (fmap p) . (fmap q)``:
```haskell
    fmap (p . q) []
    = []

    (fmap p) . (fmap q) []
    = fmap p (fmap q [])
    = [p $ q []] ++ []
    = p []
    = []
```
As we see, the behaviour will be equal for both sides, so they are in fact equal.
And for:
```haskell
    fmap (p . q) (x:xs) 
    = [(p . q) x] ++ (fmap (p . q) xs)
    = [p $ q x] ++ (fmap p (fmap q xs))
    -- e.t.c.

    (fmap p) . (fmap q) (x:xs)
    = fmap p (fmap q (x:xs))
    = [p $ q x] ++ (fmap p (fmap q xs))
```
This also matches.

## 2
### (a) Define a tree **
We can define a type ``Node`` that consists of three branches that can either be leaves or another node. 

```haskell
    data Tree = Leaf String | Node String Tree Tree Tree
```

### (b) Generalize **
```haskell
    data Tree t = Leaf t | Node t (Tree t) (Tree t) (Tree t)
```

### (c) Make it a functor **
To enable using ``fmap`` on a ``Tree``, we need to make it an instance of the ``Functor`` class.
```haskell
    instance Functor Tree where
        fmap f (Leaf x) = Leaf (f x)
        fmap f (Node v t1 t2 t3) = Node (f v) (fmap f t1) (fmap f t2) (fmap f t3)
```

### (d) Implement ``==``

## 3
### ``f`` **
We can start by making the ``*`` operator into a function, by wrapping it and the same with ``-``. This allows us to make the members into arguments.

``f x y = (*) x ((-) 3 y)``

Now we can remove ``y``

``f x = (*) x ((-) 3)``

At which point we need to ``flip`` the function to free ``x``

``f = flip $ ((*) ((-) 3))``

Which is the same as

``f = flip $ (*) . (3-)``

### ``g``
We can immideately remove ``y``

``g x = map x $ filter (<3)``

At which point we can ``flip`` ``map``.

``g = flip $ map filter (<3)``
