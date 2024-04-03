# Chapter 2
## 1
I have essentially already played around with GHCi, so skipping this.

## 2
Doing this inline, since I don't want this to be in the code file.
```haskell
-- 2^3*4 =
(2^3)*4
-- 2*3+4*5 = 
(2*3)+(4*5)
-- 2+3*4^5 =
2+(3*(4^5))
```

## 3
This is kind of funny, since I think the moment I put this in the file, VSCode will highlight the issues, though just from a glance I can see that:
1. The xs needs to be aligned with a, as indentation needs to be conistent
2. The function name starts with upper caps
3. The infix ``´div´`` needs backticks, not ticks, like: ``` `div` ```

> We also need to add the type, to enable printing, it seems?

**See ``N`` in [``ChapterTwo.hs``](ChapterTwo.hs).**

## 4
A simple one would be ``take (length list - 1) list``, though I think this one will result in a singleton list? _Yes, it does._

As the prior one did not work, kind of, another option is as suggested in the book solutions, which is ``head (reverse list)``, which is pretty elegant.

**See ``lastTake`` and ``lastHead`` in [``ChapterTwo.hs``](ChapterTwo.hs).**

## 5
One way would be to "reverse, drop, reverse". Another would be "reverse, tail, reverse".

**See ``initDrop`` and ``initTail`` in [``ChapterTwo.hs``](ChapterTwo.hs).**
