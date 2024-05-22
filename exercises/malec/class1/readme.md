# Class 1

## Basics
### 1
The idea that springs into mind immediately is to check which subtraction results in a negative number. I feel like theres better ways to do this though, but _"do the simplest thing that could possibly work"_.

**See the method ``maxi`` in [``ClassOneBasics.hs``](ClassOneBasics.hs)**

### 2
#### Recursive
When recursive, we simply want to add the current square n to the next square n-1. This will eventually compute the square of 0 (=0) -- programmatically we need to define base cases and termination though... otherwise it will go infinetely and integer overflow.

**See the method ``sumsq`` in [``ClassOneBasics.hs``](ClassOneBasics.hs)**
#### Mapping
Here we statically define the sequence of numbers immideately, no recursion. We don't need to check the 0 case either, it's simpler just to use a list starting from 0.

**See the method ``sumsqm`` in [``ClassOneBasics.hs``](ClassOneBasics.hs)**

### 3
Structurally we will define the larger rings as their radius. That is, level 2 has a radius 2, larger than level 1. The radius is an integer. 

A post is simply a list of integers.
There are always three posts, and the rule "no larger ring may lay on a smaller one" equates to the list always needs to be equal to the sorted version of that list. 
Only being able to move the top ring similarily corresponds to always lifting the first element of the list, and always prepending, not appending - in Haskell ``e:[list]``
The game can then be boiled down to a list of 3 lists, of integers, like:
``[[post 1], [post 2], [post 3]] = [[1,2,...,n-1,n], [], []]``
Where the first post is the initial list, and the remaining are initially empty as described in the pdf.  
```
      I            I             I
     -I-           I             I
    --I--          I             I
   ---I---         I             I
  ----I----        I             I
 -----I-----       I             I
========================================
```
Would correspond to ``[[1,2,3,4,5], [], []]``

The final list in the list is what will be returned upon completion. The recursion is complete when the last post contains a sorted list of ``n`` integers - ``n`` being the size of the posts, of course.

Before implementation, I will do as the pdf suggests, and try to solve the problem for n-1 rings, beginning at n=1

#### n=1
```
[[1], [], []]
[[],  [], [1]]
DONE
```
#### n=2
```
[[1,2], [],  []]  (n-1=1 begin)
[[2],   [],  [1]] (n-1=1 end)
[[2],   [1], []]
[[],    [1], [2]]
[[],    [],  [1,2]]
DONE
```
#### n=3
```
[[1,2,3], [],    []]  (n-1=2 begin)  (n-2=1 begin)
[[2,3],   [],    [1]]                (n-2=1 end)
[[2,3],   [1],   []]
[[3],     [1],   [2]]
[[3],     [],    [1,2]] (n-1=2 end)
[[1,3],   [],    [2]]
[[1,3],   [2],   []]
[[3],     [1,2], []]
[[],      [1,2], [3]]
[[1],     [2],   [3]]
[[1],     [],    [2,3]]
[[],      [],    [1,2,3]]
DONE
```
#### General solution n=n
We see that it's a case of executing the n-1 solution, moving it to the middle somehow and moving the nth ring to the last position, before again rearranging so that the middle rings end up on top of that ring.

I can't of the top of my head come up with an algorithm for this, but we can see that it seems that the amount of steps = 1 + 2 * (steps of previous step). It does not seem, from the official solutions, that I'm supposed to solve the algorithm either.

I defined a method ``hanoi``, receiving the n length of list, which computes that calculation recursively.

**See the method ``hanoi`` in [``ClassOneBasics.hs``](ClassOneBasics.hs)**

### 4
The ``nextFactor`` method should be fed a number and k, which it will find a factor larger than. As such, if we feed it recursively increasing factors k until n = k, we will get all possible factors of a number 

**See the methods ``nextFactor``, ``smallestFactor``, and ``numFactors``, in [``ClassOneBasics.hs``](ClassOneBasics.hs)**


### 5
Theres a couple approaches to this. Either we have a datatype month, containing the months, and a method that either checks the index and returns a set number of days (or from a list of days corresponding to the num month)... or we define monthnames and the set of possible monthlengths, then a month type combining the two. Examples of this, but with cards, can be found on [the Haskell wiki.](https://wiki.haskell.org/Type).

Our early definition of a date only needs then a year and a month. In the official solution, Malec chooses to set ``Month = Integer``, which I will also be doing. Though ideally you could remove the need for checking ``1 <= month <= 12`` if you design your data type such that it can't be out of range anyway.

For the second part we could simply just define year as a short date + the day. Then to check if it's valid we just need to pass the short date into the daysInMonth function.

**See the methods ``daysInMonth`` and ``validDate``, as well as the types ``Month``, ``ShortDate``, and ``Date`` in [``ClassOneBasics.hs``](ClassOneBasics.hs)**

## Lists
> [!NOTE]
> Most of these ended up being the same as the official solutions. I will be pausing this exercise until I understand the material better.

### 1
We want to walk the list in a direction and multiply the prior element with the next, we want to fold.

**See the method ``multiply`` in [``ClassOneLists.hs``](ClassOneLists.hs)**

### 2
We can't do for loops in Haskell, so our best bet is a recursive function to iterate over a list, or map.

**See the method ``substitute`` in [``ClassOneLists.hs``](ClassOneLists.hs)**

### 3
For this, we can reuse part of our prior solution (not literally), modifying it to return true if a match is found for any of the list elements. We will only need the list itself as a parameter, since we are checking elements in the list.

**See the method ``duplicates`` in [``ClassOneLists.hs``](ClassOneLists.hs)**

### 4
> [!WARNING]
> From this point on, exercise solution are done from a much more future perspective. I won't try to define any unnecessarily advanced methods though. Please contribute any solution you find more apt for this experience level, if you come across something too advanced.

``pairs`` creates all possible pairs between the two lists xs and ys, otherwise called the cartesian product.

``triads`` can easily be defined like pairs, but with the requirement that ``x^2 + y^2 = z^2``. We also need to fit the requirement that ``x <= y <= z <= n``, which is the same as creating three list generators with increasing lower bounds.

**See the method ``triads`` and ``pairs``in [``ClassOneLists.hs``](ClassOneLists.hs)**

### 5
This could be defined several ways. One way is recursion over the lists, which is probably the easiest to define. It is however true, that if we execute the pairs like ``pairs xs xs`` and compare that to ``pairs ys ys`` it should, if they are permutations, return the same pairs. This is not as simple as ``==``. Another way to implement this then, is to see if all pairs of ``pairs xs xs`` also are elements ``elem`` of ``pairs ys ys``.

**See the method ``isPermutation`` in [``ClassOneLists.hs``](ClassOneLists.hs)**

### 6
We can define a recursive helper method that modifies a pair (shortest, longest). We feed one word at a time, and modify the pair depending on wheter a word w is:
1. Shorter => pair = (w,longest)
2. Longer => pair = (shortest,w)

If there are no more words (``null words``) we return the current pair, otherwise we continue iterating if we found no new candidate.

**See the method ``shortestAndLongest`` and ``snlHelper`` in [``ClassOneLists.hs``](ClassOneLists.hs)**

### 7
It seems to disassemble the list:

``map (\y -> [y]) xs`` (iterates all elements of x and gives singleton lists of each element)

Then it folds the concat ``++`` operator, assembling them again. The direction here is foldr, but the direction does not matter here.

TL:DR; the "mystery" function disassembles and reassembles a list.

**See the method ``mystery`` in [``ClassOneLists.hs``](ClassOneLists.hs)**