# H-99 questions 21-28 :: "Lists again"
_as they were on the 17-18th of August 2024_

## 21
Should be as simple as concatenating ``take (n-1)`` with the inserted element and ``drop (n-1)``.

Let's also try to simplify it, and possibly also make it point-free:
```haskell
insertAt :: a -> [a] -> Int -> [a]
insertAt insert list at = take (pred at) list ++ insert:drop (pred at) list

insertAt = \insert list at -> (++) (take (pred at) list) (insert:drop (pred at) list) -- move parameters into body, make operators functions

insertAt = \insert list at -> (++) ((take . pred) at list) (insert:(drop  . pred) at list) -- compose take, drop with pred
```
And thats about as far as I can go with my ideas. I know it is possible to make it pointfree though. 

Heres the result: ``insertAt insert list at = (take . pred) at list ++ insert:(drop  . pred) at list``

**See the function ``insertAt`` in [``ListsAgain.hs``](ListsAgain.hs)**

## 22
This is as simple as using a list generator ``[n..m]``. I suppose you could also use ``take`` and ``drop`` in some way with an infinitely incrementing list. Don't see why you'd want to do that though.

**See the function ``range`` in [``ListsAgain.hs``](ListsAgain.hs)**

## 23
We will need to import a random module of some sort, and pick ``n`` amount of random indices within range. If the amount is larger, we will simply pick ``length list`` many random indices. These will then be concatenated.

As per [this article](https://www.schoolofhaskell.com/school/starting-with-haskell/libraries-and-frameworks/randoms) we could for example use ``replicateM n (0, length list)`` to generate our sequence of numbers.

This will require importing:
```haskell
import System.Random (randomRIO)
import Control.Monad (replicateM)
```
and install ``System.Random`` using (in Stack):
```console
stack install random
```

I'll be using do syntax, as we are in the realm of Monads now.

**See the function ``rndSelect`` in [``ListsAgain.hs``](ListsAgain.hs)**

## 24
We can use our previous function, with a generated list of numbers passed to it. We however need to modify it such that it's indices are unique. To achieve this, we can use ``shuffleM`` instead, which randomly shuffles a list. We can supply it with the range, then simply apply ``take n`` afterwards.

To use ``shuffleM``, you will need to import them using the following lines:
```haskell
import Control.Monad.Random
import System.Random.Shuffle
```
after installing ``System.Random.Shuffle`` by using (in Stack):
```console
stack install random-shuffle
```

You may have to run ``ghci`` as ``stack ghci`` to run it now, atleast I had to.

**See the functions ``diffSelect`` and ``uniqueSelect`` in [``ListsAgain.hs``](ListsAgain.hs)**

## 25
We can use the ``shuffleM`` function previously discovered to do this, in the same way we did with the prior exercise (using ``uniqueSelect``).

For this to work we'll just pass the length of the list along with the list to the uniqueSelect function. This starts of as ``rndPermu list = uniqueSelect list length list``, but can be simplified like:

```haskell
rndPermu list = flip uniqueSelect length list list
rndPermu = flip uniqueSelect . length >>= id -- eliminate the double argument use, by "forwarding"
rndPermu = uniqueSelect <*> length -- hlint suggestion
```

The ``<*>`` in this instance is essentially forming ``uniqueSelect . length``, but to be honest I do not fully understand the concept of applicative functors yet...

**See the functions ``rndPermu`` and ``uniqueSelect`` in [``ListsAgain.hs``](ListsAgain.hs)**

## 26
For this solution, I ended up having to reference the existing solutions, as I couldn't make it further than needing to use list generators. I'll try to explain it anyway though.

Every iteration we generate a list of possible indices, and fetch every single item. This creates a list of lists consisting solely of our elements, for example for ``"abcdef"`` we get ``["a","b","c","d","e","f"]``. To each of these elements we tack on the next iteration (specific to each element), which picks one less element, in a list where we have dropped an amount of elements equal to the index.

For example, "a" passes on ``combinations 2 "bcdef"``, and "c" passes on ``combinations 2 "def"``. In each of these steps we create another list of initials, ``["b","c","d","e","f"]`` and ``["d","e","f"]`` in this case. We can imagine it as a tree (which tends to be the typical way to illustrate these things).

To be honest, this was only hard because I have **completely** forgotten combinatorics. It truly is a lost cause... :o

**See the function ``combinations`` in [``ListsAgain.hs``](ListsAgain.hs)**

## 27
Can't be bothered. I hate combinatorics bro.

## 28
### a)
We can use ``sortBy`` from the ``Data.List`` module. You can also implement your own sorting algorithm, but I don't care to do so.

We then get ``lsort list = sortBy (\x y -> compare (length x) (length y)) list`` which can be simplified to ``lsort = sortBy (\x y -> compare (length x) (length y))``. It can be simplified further if we import some more functions (for example ``on`` or ``comparing``), but I don't want to bloat my solution too much.

**See the function ``lsort`` in [``ListsAgain.hs``](ListsAgain.hs)**

### b)
We can use ``sortBy`` again, now supplying it with the length of the list filtered by lists that are of the same length.

This initially comes out as the unwieldly: 
```haskell
lfsort :: [[a]] -> [[a]]
lfsort list = sortBy (\x y -> compare (length (filter (\z -> length z == length x) list)) (length (filter (\z -> length z == length y) list))) list
```
So we can define a little helper function ``countSameLength``, at which point we get ``lfsort list = sortBy (\x y -> compare (countSameLength x list) (countSameLength y list)) list``

**See the function ``lfsort`` in [``ListsAgain.hs``](ListsAgain.hs)**
