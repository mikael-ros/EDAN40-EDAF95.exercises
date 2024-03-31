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

**See the methods ``nextFactor``, ``smallestFactor``, ``numFactors``, in [``ClassOneBasics.hs``](ClassOneBasics.hs)**