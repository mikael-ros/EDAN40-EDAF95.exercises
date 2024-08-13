module June where
-- 1
-- f
f, f', f'', f''', f'''', f''''' :: Fractional a => a -> a -> a
f x y = 5 / (x + y)

f' = \y -> (\x -> 5 / (x + y))
f'' = \y -> (\x -> (/) 5 . (+) x $ y)
f''' = \x -> (/) 5 . (+) x
f'''' = \x -> (.) (5/) ((+) x)
f''''' = (.) (5/) . (+)

-- g
g, g', g'', g''', g'''', g''''', g'''''', g''''''':: Integer -> (Integer -> Integer) -> [Integer]
g x y = [y z | z <- [x..]]
g' x y = map y [z | z <- [x..]]
g'' x y = map y (iterate (+1) x)
g''' x y = map y (iterate succ x)
g'''' = \x -> (\y -> map y (iterate succ x))
g''''' = \x -> (\y -> flip map (iterate succ x) y)
g'''''' = \x -> flip map (iterate succ x)
g''''''' = flip map . iterate succ
