# H-99 questions 11-20 :: "Lists again"
_as they were on the 17th of August 2024_

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
```sh
    stack install random
```

I'll be using do syntax, as we are in the realm of Monads now.

**See the function ``rndSelect`` in [``ListsAgain.hs``](ListsAgain.hs)**

## 24
We can use our previous function, with a generated list of numbers passed to it. We however need to modify it such that it's indices are unique. For now I will leave it as it is, will try to fix that next time!

**See the functions ``diffSelect`` and ``uniqueSelect`` in [``ListsAgain.hs``](ListsAgain.hs)**


