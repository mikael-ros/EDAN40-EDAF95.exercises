module ChapterThree where
    ----------------------
    -- -- Exercise 2 -- --
    ----------------------
    bools :: [Bool]
    bools = [True, False] -- Can be whatever length, really

    nums :: [[Int]]
    nums = [[1],[2]]

    add :: Int -> Int -> Int -> Int -- This curried type could for example be equivalent to (Int,Int,Int) -> Int (A method that sums three numbers)
    add a b c = a + b + c

    copy :: a -> (a,a) -- Returns a tuple of the same item
    copy item = (item, item)

    apply :: (a -> b) -> a -> b -- Should apply a method onto something
    apply method something = method something

    ----------------------
    -- -- Exercise 3 -- --
    ----------------------
    -- Defining the methods here for ease of double-checking
    second xs = head (tail xs)

    swap (x,y) = (y,x)

    pair x y = (x,y)

    double x = x*2

    palindrome xs = reverse xs == xs

    twice f x = f (f x)