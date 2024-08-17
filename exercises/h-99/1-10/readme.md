# H-99 questions 1-10 :: "Lists"
_as they were on the 16th of August 2024_

## 1
One immediate simple solution is to take the ``head`` of the ``reverse`` list, like: ``head (reverse list)``, which is the same as the composition of head and reverse, supplied with the list: ``head . reverse list``. At which point we can remove the list argument and get: ``head . reverse``.

Another fairly simple version of this would be a recursive function that stops when it has reached the end of the list. We don't need to track the index, we can just use ``x:xs`` and check whether the remainder ``xs`` is empty - if so we have reached the last element.

**See the functions ``myLast`` and ``myLast'`` in [``Lists.hs``](Lists.hs)**

## 2
We can easily adapt the second solution of problem 1 by instead checking if the remainder list ``xs`` is of length ``1``.

Another really simple one is to immediately call the ``!!`` operator with the length of the list minus two.

**See the functions ``myButLast`` and ``myButLast'`` in [``Lists.hs``](Lists.hs)**

## 3
To clarify, this is ``!!``, but we start at index 1, not 0. Hence the simplest solution is to just call ``!!`` with ``index - 1``.

We then get:
```haskell
    elementAt :: [a] -> Int -> a
    elementAt xs index = xs !! (index - 1) 
```

Which we can reduce like:
```haskell
    elementAt' = \xs -> (\index -> xs !! (index - 1)) -- move arguments to right hand side
    elementAt'' = \xs -> (\index -> (!!) xs ((-) index 1)) -- move operators left
    elementAt''' = \xs -> (\index -> (!!) xs ((subtract 1) index)) -- replace with subtract, so we can move index right
    elementAt'''' = \xs -> (\index -> ((!!) xs) ((subtract 1) index)) -- create partially applied function ((!!) xs)
    elementAt''''' = \xs -> (\index -> (((!!) xs) . (subtract 1)) index) -- replace with composition
    elementAt'''''' = \xs -> ((!!) xs) . (subtract 1) -- remove index, as it is no longer needed

    -- finally, we get:
    elementAt xs = (!!) xs . subtract 1
```
It is possible to go further with more advanced operators, but I do not understand them currently. There is another fully point free solution on the wiki as well.

Another solution is to recursively iterate again, until the length of the remaining list is the length of the list minus the index, but then we would have to track the original length of the list, which is bothersome.

**See the function ``elementAt`` in [``Lists.hs``](Lists.hs)**

## 4
One solution is to define a recursive function that counts until it reaches the end, at which point it returns the number. Another is using fold to accumulate 1's (basically the same thing but shorter).

For the first one, if we want to adhere to the signature ``[a] -> Int``, we have to define a helper function.

**See the functions ``myLength`` and ``myLength'`` in [``Lists.hs``](Lists.hs)**

## 5
One way is to fold from the right, as ``foldr`` starts at the end of the list. Hence using the concatenation operator in the process will yield the opposite order of elements.

Another would be to recursively go through a list, and empty it in the process. This is equivalent to folding, but would require another parameter to track the new list.

**See the functions ``myReverse`` and ``myReverse'`` in [``Lists.hs``](Lists.hs)**

## 6
One approach is to check if either side of the middle are equal when one is reversed. This would be simplified by introducing a slice method to create said sides.

**See the functions ``slice`` and ``isPalindrome'`` in [``Lists.hs``](Lists.hs)**

## 7
Like mentioned in the wiki, lists in Haskell are homogenous, which means they can only hold items of the same type ``a``. An unfortunate side effect of this is that since a nested list will be of the type ``[a]`` we cannot store it in another list of type ``[a]``, as said list would have to be of type ``[[a]]`` - preventing us from also storing simple elements. We need something like ``[a|[a]]``, which doesn't exist!

We therefore need to define a new non-homogenous list type. I will be using the one suggested in the wiki.

We would either need to define an instance of ``Functor`` (to use ``fmap``) or we can do it recursively. Since I assume these tasks are supposed to be simple so far, I will avoid the first route.

The recursive method will have two cases:
1. A single element => prepend the element to the flattened list
2. A list => recursively call (fold) ``myFlatten`` over each element in the list, and prepend this to the flattened list (accumulator)

**See the functions ``myFlatten`` and ``myFlattenHelper'`` in [``Lists.hs``](Lists.hs)**

## 8
I think we could leverage something like ``dropWhile``, recursively. Essentially, we ``dropWhile``, then pass on the list onto the next iteration. This is equivalent to folding ``dropWhile (==x)`` over the list.

**See the function ``compress`` in [``Lists.hs``](Lists.hs)**

## 9
This could probably be defined similar to the previous exercise, but I had issues making it work. The main issue is that the list needs to be consumed during the folding (so we don't get a string like ``"aaaa"`` for every instance of ``"a"``).

I found it easier to just create a helper that ``dropWhile``s the element each iteration from the list, and adds the ``takeWhile`` to a list. At the end it needs to be reversed.

**See the functions ``pack`` and ``packHelper'`` in [``Lists.hs``](Lists.hs)**

## 10
We should be able to easily use the prior solution with some kind of zipping/mapping function, or define an edited version of ``pack`` that stores the values in the tuples. I'll do both.

The first version can simply defined by mapping a function that pairs the length with the head, and passes the packed version onto this. The second is as simple as storing the length of the list with the current element in a pair.

**See the functions ``encode``, ``encodeHelper``, and ``encode'`` in [``Lists.hs``](Lists.hs)**

