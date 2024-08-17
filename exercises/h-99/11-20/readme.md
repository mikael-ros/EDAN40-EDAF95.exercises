# H-99 questions 11-20 :: "Lists continued"
_as they were on the 17th of August 2024_

## 11
We can similar to question 10 choose to do it in two ways. I'll simply import ``pack`` from the [previous section](../1-10/Lists.hs) (inline, since I can't get the import statement to work in this directory), and use it to define a function similar to ``encode'``. Now we just have to add a new type, perhaps ``Encoding``, that is either a ``Multiple Int a`` or a ``Single a``: ``data Encoding a = Multiple Int a | Single a``.

To cut down on bloat, I'll define a helper function ``createEncoding``, but you could also write the entire function inline like:

```haskell
    encodeModified :: Eq a => [a] -> [Encoding a]
    encodeModified = map (\l -> if length l > 1 then Multiple (length l) (head l) else Single (head l)) . pack
```

but I find ``encodeModified = map createEncoding . pack`` to be more elegant.

**See the functions ``encodeModified`` and ``createEncoding'`` in [``ListsContinued.hs``](ListsContinued.hs)**

## 12
We can use the ``Prelude`` function ``replicate``, using the length encoded in the ``Encoding`` type, and then concatenate all of them.

Initially I'll get something like
```haskell
    decode = concat . map (\e -> replicate (fst (decodeEncoding e)) (snd (decodeEncoding e)))
```
which we can further reduce like:
```haskell
    decode' = concatMap (\e -> replicate (fst (decodeEncoding e)) (snd (decodeEncoding e))) -- replace concat . map with concatMap
```
At which point hlint quickly suggests me to write it like ``decode = concatMap (uncurry replicate . decodeEncoding)``

**See the functions ``decode`` and ``decodeEncoding'`` in [``ListsContinued.hs``](ListsContinued.hs)**

## 13
Since I found their instructions a little muddy I'll just quickly clarify that they mean not to use the ``pack`` function, but to create the encodings immediately.

I'll simply modify my other version of ``encode`` from the [previous section](../1-10/Lists.hs).

**See the functions ``encodeDirect`` and ``encodeDirectHelper'`` in [``ListsContinued.hs``](ListsContinued.hs)**

## 14
This should be as simple as using ``replicate`` with ``concatMap``.

**See the function ``dupli`` in [``ListsContinued.hs``](ListsContinued.hs)**

## 15
This should be as simple as using ``replicate`` with ``concatMap``, again. This time we do not supply the amount of replications. To preserve the order of arguments we'll have to flip the composition, as ``concatMap . replicate`` is of type ``Int -> [a] -> [a]`` and we need ``[a] -> Int -> [a]``.

**See the function ``repli`` in [``ListsContinued.hs``](ListsContinued.hs)**

## 16
One way to achieve this would be to track the amount of elements traversed and skip an element when the traversal is divisible by 3 (``index `mod` 3 == 0``). We could also use a list generator with a similar requirement. I'll do both. The second will need the elements to be of a type that is an instance of ``Eq``.

**See the functions ``dropEvery`` and ``dropEvery'`` in [``ListsContinued.hs``](ListsContinued.hs)**

## 17
I can either use my ``slice`` function from the last section to create two slices, one from 0 to the given number (-1) and the other from the given number (+1) to the length, or I can use ``take`` and then pair it with ``drop``. I'll do both, even if the second is far simpler.

**See the functions ``split`` and ``split'`` in [``ListsContinued.hs``](ListsContinued.hs)**

## 18
Lol, foresight would have been useful here. I'll be using the previously defined ``slice``, with modifications to satisfy the indexing preferred by the wiki contributors.

**See the function ``slice`` in [``ListsContinued.hs``](ListsContinued.hs)**

## 19
When the number is positive, we simply append ``take n`` to the end of ``drop n``. When the number is negative, we have to adjust it so it matches with the length minus the absolute value (ex. n = -2 in a list of length 5 will be computed to n = 3). Further, we need to handle inputs larger than the list length. 

This can be simplified and handled as modulo over double the list length, again modulo over list length. ``(degree `mod` (2*length list)) `mod` length list``

Example:

If the list length is 5, and we want to rotate -2, we first get

``-2 `mod` 2*5`` = ``8``, 

then this gets passed on

``8 `mod` 5`` = ``3``

And if we try a positive number we'll get ``2 `mod` 2*5`` = ``2``, passed on ``2 `mod` 5`` = 2. The number gets preserved, and we also don't need to worry about numbers larger than the list either thanks to modulo. 

**See the function ``rotate`` in [``ListsContinued.hs``](ListsContinued.hs)**

## 20
We could use the ``slice`` function, then some kind of filter. Another way is to track our traversal, and yet another way is to ``take n``, take its last element, and then concatenate the remainder with ``drop n``. We could also use our previously defined ``split`` function, and simply concatenate both members of the tuple, excluding the last element of the first member which we reserve (this is the same as the previous suggestion). I'll implement a couple.

**See the function ``removeAt`` and ``removeAt'`` in [``ListsContinued.hs``](ListsContinued.hs)**
