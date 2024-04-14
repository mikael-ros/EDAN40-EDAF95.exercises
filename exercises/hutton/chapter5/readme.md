# Chapter 5
## 1
We first apply the first example in the chapter, then run the sum function on that.

A quick Google search reveals the answer should be 338350.

**See ``hundredSquares`` in [``ChapterFive.hs``](ChapterFive.hs)**

## 2
We will simply just need to create a list comprehension with the two ranges, and pair them as the output.

**See ``grid`` in [``ChapterFive.hs``](ChapterFive.hs)**

## 3
Should be as simple as calling ``grid n n``, with the restriction/filter that x does not equal y -- ``x /= y``.

**See ``square`` in [``ChapterFive.hs``](ChapterFive.hs)**

## 4
We can use ``_ <- list`` as a generator, which will essentially "throw away" every element of a list. The list used as the generator sacrifice is ``[1..n]``, so we step the n times required for the function.

**See ``replicate`` in [``ChapterFive.hs``](ChapterFive.hs)**

## 5
We will generate the components x, y and z with ``[1..n]`` and set the rule/filter ``x^2 + y^2 = z^2``.

**See ``pyths`` in [``ChapterFive.hs``](ChapterFive.hs)**


## 6
Factors should simply be a method that generates numbers ``[1..n-1]`` with the requirement ``n `mod` x``. _``n-1`` as the cap, as we want to disclude the number itself_

Perfects similarly generates a list of numbers ``[1..n]`` with the requirement ``x == sum factors x`` or similar.

**See ``factors`` and ``perfects`` in [``ChapterFive.hs``](ChapterFive.hs)**

## 7 
We just need to generate them seperately and concatenate them like suggested.