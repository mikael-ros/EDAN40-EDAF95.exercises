# Chapter 7
## 1
This comprehension describes evaluating the predicate function ``p`` on every x in xs, and only including those in the list of arguments to map f onto.

This is, of course, equivalent to ``filter`` and ``map``, which can be run in any order, but best would probably be ``filter`` followed by ``map``, which in Haskell would be written something like ``map f (filter p xs)``. We'll try this by creating a simple predicate ``isEven x``, and running a function equivalent to dividing by two.

With an input of ``[1,2,3,4,5,6]`` this should return ``[4,8,12]``.

**See ``isEven``, ``doubler``, and ``doubleEvenNumbers`` in [``ChapterSeven.hs``](ChapterSeven.hs)**

## 2

### all
> [!NOTE]
> I could not get this to compile without changing the list type from [Bool] to [a]

We just need to map the predicate function and check if the result is a list of solely ``True``. Then we can run the and function on that, which will return wheter all elements are True.

An initial draft of this, looks like:
```haskell
    all p xs = and (map p xs)
```
Which is trivially rewritten to the composition (remember a composition is a function inside a function) with the composition operator `` ( . ) ``, like: ``all p = and . map p`` _(xs will be omitted, as this composition will already have that parameter with map)_

### any
This will be the same as all, just with the ``or`` operator.

### takeWhile
Here we can use the ``all`` function previously define, and recursively increase the n in ``take n`` until ``all take n xs == false``, at which point we'll return ``take n-1 xs``.

Unfortunately, however, as I realized while typing, we can't do that without diverging the function type. So we'll use a solution akin to the book's. 

### dropWhile
This is very similar to takeWhile, except we want to return xs at the end and simply throw away x at every iteration.

**See ``all``, ``any``, ``takeWhile`` and ``dropWhile`` in [``ChapterSeven.hs``](ChapterSeven.hs)**

## 3 
We can do this by applying foldr to the function. We'll have to get the parameters by anonymous functions. For filter we can pass a function into the map function, or we can define it like in the book.

**See ``map'`` and ``filter'`` in [``ChapterSeven.hs``](ChapterSeven.hs)**

## 4 
This is similar, but opposite, to the function ``bin2int``, since the first argument is the accumulator in ``foldl`` as opposed to ``foldr`` where it is the second. Obviously here, we have a base of 10, and as such use ``10*x``.

We can analyze this, by computing it.
```
a*10^3 + b*10^2 + c*10 + d
= (a*10^2 + b*10 + c)*10 + d
= ((a*10 + b)*10 + c)*10 + d
= (((a)*10 + b)*10 + c)*10 + d
```
Again, since the left part is the accumulator, we can say that the rule is ``10x + y``.

**See ``dec2int`` in [``ChapterSeven.hs``](ChapterSeven.hs)**

## 5
Couldn't fint a good solution for this, at all. I used the solution in the book.

I don't fully understand this section. I assume it has something to do with the section on composition, somehow.

**See ``curry`` and ``uncurry`` in [``ChapterSeven.hs``](ChapterSeven.hs)**


## 6