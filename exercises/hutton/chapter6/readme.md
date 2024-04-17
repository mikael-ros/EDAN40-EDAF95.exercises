# Chapter 5
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


