# Chapter 3
## 1
``['a', 'b', 'c'] :: [Char]`` _(' ' denotes a char)_

``('a', 'b', 'c') :: (Char, Char, Char)`` _(tuples are defined with a type at each position)_

``[(False, '0'), (True, '1')] :: [(Bool, Char)]`` _(the number is wrapped in ' ' and is such a character)_

``([False,True], ['0','1']) :: ([Bool],[Char])`` _(again, tuples are defined with a type at each position, and the numbers are wrapped as characters)_

``[tail, init, reverse] :: [[a] -> [a]]`` _(a list of methods that return lists, which can internally have any type, therefore ``a``)_

## 2
**See ``bools``, ``nums``, ``add``, ``copy`` and ``apply`` in [``ChapterThree.hs``](ChapterThree.hs)**

> [!NOTE]
> No tests are provided for this exercise, since theres no point

## 3
> [!TIP]
> Double check types in ``ghci`` with ``:type <method>``, when you are not sure. I have got all the methods defined in [``ChapterThree.hs``](ChapterThree.hs) if you don't want the hassle of having to type them into ghci.

It takes a list, grabs everything but the first element, and grabs the first element out of that. => 
``[a] -> a``

It swaps the positions in a tuple => ``(a,b) -> (b,a)``

It pairs to elements => ``(a,b) -> (a,b)`` or if curried ``a -> b -> (a,b)``

It doubles a number, hence we need to restrict it to Num => ``Num a -> a``

It checks a list and returns a bool, but we also need to restrict it to something that can be compared, an Eq type => ``Eq a => [a] -> Bool``

It applies a function twice. Not sure how to write this one, to be honest.

## 4
Already done.

## 5
Given the hint I would say it is because they are then the same function and redundant?
