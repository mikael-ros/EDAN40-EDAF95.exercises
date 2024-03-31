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
