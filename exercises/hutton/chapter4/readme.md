# Chapter 4
## 1
We could use pattern matching. If it were only the list in the example, it could be as easy as something like ``[a,a,a,_,_,_]``, but we need something more general.

I also realized when checking the solutions from the book, that we're not supposed to use pattern matching yet, just standard library stuff so far.

**See ``halve`` in [``ChapterFour.hs``](ChapterFour.hs)**

## 2
> I will implement all of these using guards, not conditional statements.

### Using head and tail
We can just call tail twice, then grab head. Think of it as walking through the list, I guess.

### Using list indexing ``!!``
This ones trivial.

### Using pattern matching
This should be something like ``(_:_:e:_)``. We can't check the length here I think, but it should be okay?

**See ``thirdHead``, ``thirdIndex``, ``thirdPattern`` in [``ChapterFour.hs``](ChapterFour.hs)**

## 3

### Using conditional expressions
We can return the list when empty, instead of mapping to an empty list, since the list is already empty.

### Using guards
Same as conditional, just guards.

### Using pattern matching
We can match everything but the first element.

**See ``safetailCond``, ``safetailGuard``, ``safetailPattern`` in [``ChapterFour.hs``](ChapterFour.hs)**