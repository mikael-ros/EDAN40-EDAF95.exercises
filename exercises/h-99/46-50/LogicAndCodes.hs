module LogicAndCodes where
    import Control.Lens
    -----------------------
    -- -- Exercise 46 -- --
    -----------------------
    and2, and2', or2, or2', nand2, nand2', nor2, nor2', xor2, xor2', xor2'', impl2, equ2, equ2' :: Bool -> Bool -> Bool -- They all have the same signature
    
    -- and
    and2 = (&&)

    and2' True b = b
    and2' False _ = False 

    -- or
    or2 = (||)
    
    or2' True _ = True
    or2' False b = b

    -- nand
    nand2 = (not .) . and2

    nand2' True b = not b
    nand2' False _ = True

    -- nor
    nor2 = (not .) . or2

    nor2' True _ = False
    nor2' False b = not b

    -- xor
    xor2 = (/=)

    xor2' a b = nor2 (nor2 a b) (and2 a b)
    
    xor2'' True b = not b
    xor2'' a False = a
    xor2'' False b = b

    -- impl
    impl2 True b = b
    impl2 False b = True 

    -- equ
    equ2 = (==)

    equ2' True b = b
    equ2' a False = not a
    equ2' False b = not b

    -- Truth table
    generateValues2 :: [(Bool,Bool)]
    generateValues2 = [(a,b) | a <- bools, b <- bools]
        where bools = [True,False]

    computeExpression2 :: (Bool -> Bool -> Bool) -> [Bool]
    computeExpression2 fn = map (uncurry fn) generateValues2

    generateTable2 :: (Bool -> Bool -> Bool) -> [(Bool,Bool,Bool)] 
    generateTable2 fn = zip3 (map fst generateValues2) (map snd generateValues2) (computeExpression2 fn) 

    generateTableString2 :: (Bool -> Bool -> Bool) -> String -- this is really ugly
    generateTableString2 fn = foldr (\row acc -> 
        foldr ((\v row -> 
            v++" "++row) . show) "" [row ^. _1, row ^. _2, row ^. _3]
        ++"\n"++acc) 
        "" (generateTable2 fn)

    printTable2 :: (Bool -> Bool -> Bool) -> IO ()
    printTable2 = putStrLn . generateTableString2
    
    -----------------------
    -- -- Exercise 47 -- --
    -----------------------
    (/\), (\/) :: Bool -> Bool -> Bool
    (/\) = and2 
    (\/) = or2 

    infixl 6 /\
    infixl 4 \/

    -----------------------
    -- -- Exercise 48 -- --
    -----------------------
    -- Operators
    (%), (!\/), (!/\), (===), (==>) :: Bool -> Bool -> Bool
    (%) = xor2 
    (!\/) = nor2
    (!/\) = nand2
    (===) = equ2
    (==>) = impl2 

    infixl 5 %
    infixl 4 !\/
    infixl 3 ===
    infixl 6 !/\
    infixl 3 ==>
    
    -- Generalizing the tables
    -- cant be bothered

    -----------------------
    -- -- Exercise 49 -- --
    -----------------------
    gray :: Int -> [String]
    gray 0 = [""]
    gray n = ['0':x | x <- predGray] ++ ['1':x | x <- reverse predGray]
        where predGray = gray (pred n)

    -----------------------
    -- -- Exercise 50 -- --
    -----------------------
    -- skipping