# [Exam 2023-06-01](https://fileadmin.cs.lth.se/cs/Education/EDAN40/exams/edan40_230601.pdf)
## 1
### ``the function f x y``
```haskell
    f :: Fractional a => a -> a -> a
    f x y = 5 / (x + y)
    f' = \y -> (\x -> 5 / (x + y))          -- 1
    f'' = \y -> (\x -> (/) 5 . (+) x $ y)   -- 2
    f''' = \x -> (/) 5 . (+) x              -- 3
    f'''' = \x -> (.) (5/) ((+) x)          -- 4
    f''''' = (.) (5/) . (+)                 -- 5
```
1. Curry the function (move the arguments to the right hand side).
2. Move operators over as if they are normal functions (which they are).
3. Remove the ``y`` parameter, as it has now been pushed to the right far enough.
4. Move the ``(.)`` operator to the left.
5. Remove ``x``, and make the union. We have now achieved one possible point-free version of this method. 

### ``the function g x y``
``y`` is in this case a function itself, with the type ``Integer -> Integer``. As it is applied to every element of the comprehension generator ``[x..]``, it is essentially equivalent to mapping ``y`` over that list, which can be our first "attack vector".

```haskell
    g x y = [y z | z <- [x..]]
    g' x y = map y [z | z <- [x..]]                     -- 1
    g'' x y = map y (iterate (+1) x)                    -- 2
    g''' x y = map y (iterate succ x)                   -- 3
    g'''' = \x -> (\y -> map y (iterate succ x))        -- 4
    g''''' = \x -> (\y -> flip map (iterate succ x) y)  -- 5
    g'''''' = \x -> flip map (iterate succ x)           -- 6
    g''''''' = flip map . iterate succ                  -- 7
```
1. Move the y function out of the comprehension by using map, as suggested above.a
2. Replace the now redundant generator. As it will generate [x, x+1, x+1+1,...], we can instead use ``iterate``.
3. We can now replace ``+1`` with ``succ``.
4. We can now curry it.
5. We can then flip the map function (making it take the function as it's second rather than first parameter), to move over ``y``.
6. We can after that remove the parameter ``y``.
7. Now we can finally remove ``x`` and make the union. We are now done.

## 2
### ``($ ($))``
The ``$`` operator essentially makes the right hand side become the input for the lefthand side. This means that the right ``$`` puts the right-hand of itself into the other ``$``. 

Now, the ``$`` operator has the type ``(a -> b) -> a -> b``, as it's first parameter is a function on some type a, that turns it into a type b. As such, the other parameter needs to be the type a, and it will ultimately return the function output b. As we are operating ``$`` on ``$`` the function ``a -> b`` is ``$`` in this case, which gives a doubly nested version:
``((a -> b1) -> a -> b1) -> a -> b2``, where b1 and b2 are two different possible types of output.

### ``(. (.))``
> [!WARN]
> This part is incomplete, will get back to this another time.

The ``(.)`` operator is the union operator, and essentially puts one function inside the other. An union can only be done, as is the case in mathematics, when the output type of one function is the same as the other functions input. This gives the type signature ``(b -> c) -> (a -> b) -> (a -> c)``. 

When ``(.)`` itself is the function of the union, we get ``((b -> c) -> (a -> b) -> (a -> c)) -> (a -> b) -> (a -> (a -> c))``
