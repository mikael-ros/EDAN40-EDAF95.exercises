# Chapter 6
## 1
It never reaches the base case, and iterates downward for infinity. To fix it we simply just need to prohibit negative inputs, like suggested.

**See ``facFixed`` in [``ChapterSix.hs``](ChapterSix.hs)**

## 2
This will essentially just be fac, but with addition rather than multiplication.

**See ``sumdown`` in [``ChapterSix.hs``](ChapterSix.hs)**

## 3
We will not need to define that ``n == 0`` will give 0, but I do so anyway to avoid unnecessary recursion in that case. However, ``p == 0`` needs to set to give 1 for the loop to work. In any negative case we return 0.

This implementation would give the evaluation 
```haskell
power 2 3 = 
    2 * (power 2 2) = 
        2 * 2 * (power 2 1) = 
            2 * 2 * 2 * (power 2 0) = 
                2 * 2 * 2 * 1
```

> [!TIP]
> ``power`` can also be named ``^``, but for readability I chose to name it ``power``.

**See ``power`` in [``ChapterSix.hs``](ChapterSix.hs)**

## 4

**See ``euclid`` in [``ChapterSix.hs``](ChapterSix.hs)**

## 5
### ``length [1,2,3]``
```haskell
length [1,2,3] =
    1 + length [2,3] =
        1 + 1 + length [3] =
            1 + 1 + 1 = 3
```

### ``drop 3 [1,2,3,4,5]``
```haskell
drop 3 [1,2,3,4,5] =
    drop 2 [2,3,4,5] =
        drop 1 [3,4,5] =
            drop 0 [4,5] =
                [4,5]
```

### ``init [1,2,3]``
```haskell
init [1,2,3] =
    1 : init [2,3] =
        1 : 2 : init [3] =
            1 : 2 : [] = [1,2]
```

## 6
### and
We can simply use the ``&&`` operator, recursively grabbing the first element in the list of booleans. When the list is empty, the base case is just ``True`` (so we don't "pollute" any prior results).

### concat
Here we can do sismilar as ``and``, instead opting to use the ``++`` operator and having the first list as a basecase.

### replicate
Here we want to make any negative amount return the empty list. When the amount is 1, we just want the element, and otherwise we want to append the element to the return of the method one step below.

### !!
Here we can count down the index and iterate through the list, and when we reach 0 we can grab the current head.

### elem
Here we can iterate through the list, returning true when an element is found. We also need to return false if the list is empty.

**See ``and``, ``concat``, ``replicate``, ``!!`` and ``elem`` in [``ChapterSix.hs``](ChapterSix.hs)**

## 7
Since the lists are sorted, we can assume that in each list the head is the smallest element, and as such we can recursively compare heads to sort them together.

**See ``merge`` in [``ChapterSix.hs``](ChapterSix.hs)**

## 8

Halve just needs to be a function returning the take and drop of the same length, I think. Preferrably with a floor and roof, or something.

The msort function is just classic mergesort, using the defined merge function.

**See ``msort`` in [``ChapterSix.hs``](ChapterSix.hs)**

## 9
_The 5 step method boils down to defining the type of function, then conjuring all the cases, defining the easy cases first and simpler last. Last step is refactoring._
### sum
The type of this function should be ``Num a => [a] -> a``

The possible cases would be:
- empty list = 0
- singleton list = the sole element
- any other list = recursive addition with rest of list, until singleton is reached

### take
The type of this function should be ``Int -> [a] -> [a]``

The possible cases would be:
- the number of elements taken 0 = empty list
- list is empty = empty list
- the number of elements is larger or equal to list length = whole list
- otherwise = concat head with take n-1 rest of list

### last
The type of this function should be ``[a] -> a``

The possible cases would be:
- list is empty = undefined
- singleton = the sole element
- any other list = call the last function with everything but the head

**See ``sum``, ``take`` and ``last`` in [``ChapterSix.hs``](ChapterSix.hs)**