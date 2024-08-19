module TestsLogicAndCodes where
    import Test.HUnit
    import LogicAndCodes

    testsAnd = TestList [
            and2    True    True    ~?= True,
            and2    False   True    ~?= False,
            and2    True    False   ~?= False,
            and2    False   False   ~?= False,
            and2'   True    True    ~?= True,
            and2'   False   True    ~?= False,
            and2'   True    False   ~?= False,
            and2'   False   False   ~?= False
        ]

    testsOr = TestList [
            or2     True    True    ~?= True,
            or2     False   True    ~?= True,
            or2     True    False   ~?= True,
            or2     False   False   ~?= False,
            or2'    True    True    ~?= True,
            or2'    False   True    ~?= True,
            or2'    True    False   ~?= True,
            or2'    False   False   ~?= False
        ]

    testsNand = TestList [
            nand2    True    True    ~?= False,
            nand2    False   True    ~?= True,
            nand2    True    False   ~?= True,
            nand2    False   False   ~?= True,
            nand2'   True    True    ~?= False,
            nand2'   False   True    ~?= True,
            nand2'   True    False   ~?= True,
            nand2'   False   False   ~?= True
        ]

    testsNor = TestList [
            nor2     True    True    ~?= False,
            nor2     False   True    ~?= False,
            nor2     True    False   ~?= False,
            nor2     False   False   ~?= True,
            nor2'    True    True    ~?= False,
            nor2'    False   True    ~?= False,
            nor2'    True    False   ~?= False,
            nor2'    False   False   ~?= True
        ]

    testsXor = TestList [
            xor2     True    True    ~?= False,
            xor2     False   True    ~?= True,
            xor2     True    False   ~?= True,
            xor2     False   False   ~?= False,
            xor2'    True    True    ~?= False,
            xor2'    False   True    ~?= True,
            xor2'    True    False   ~?= True,
            xor2'    False   False   ~?= False,
            xor2''   True    True    ~?= False,
            xor2''   False   True    ~?= True,
            xor2''   True    False   ~?= True,
            xor2''   False   False   ~?= False
        ]

    testsImpl = TestList [
            impl2     True  True    ~?= True,
            impl2     True  False   ~?= False,
            impl2     False True    ~?= True,
            impl2     False False   ~?= True
        ]

    testsEqu = TestList [
            equ2     True  True    ~?= True,
            equ2     True  False   ~?= False,
            equ2     False True    ~?= False,
            equ2     False False   ~?= True,
            equ2'    True  True    ~?= True,
            equ2'    True  False   ~?= False,
            equ2'    False True    ~?= False,
            equ2'    False False   ~?= True
        ]

    testValueGen = generateValues2 ~?= [
            (True, True),
            (True, False),
            (False, True),
            (False, False)
        ]

    testComputing = computeExpression2 and2 ~?= [True,False,False,False]

    testTableGen = generateTable2 and2 ~?= [
        (True, True, True),
        (True, False, False),
        (False, True, False),
        (False, False, False)
        ]

    testTableStringGen = generateTableString2 and2 ~?=     "True True True \n" 
                                                        ++ "True False False \n"
                                                        ++ "False True False \n"
                                                        ++ "False False False \n"

    testsExercise46 = TestList [
        testsAnd,
        testsOr,
        testsNand,
        testsNor,
        testsXor,
        testsImpl,
        testsEqu,
        testValueGen,
        testComputing,
        testTableGen,
        testTableStringGen
        ]

    {-testExercise48 = generateTableStringN 3 (\[a,b,c] -> a /\ (b \/ c) === a /\ b \/ a /\ c) ~?= 
           "True  True  True  True \n"
        ++ "True  True  False True \n"
        ++ "True  False True  True \n"
        ++ "True  False False True \n"
        ++ "False True  True  True \n"
        ++ "False True  False True \n"
        ++ "False False True  True \n"
        ++ "False False False True \n"-} -- uncomment if you desire to complete exercise 48

    testExercise49 = gray 3 ~?= ["000","001","011","010","110","111","101","100"]
    
    --testExericse50 = huffman [('a',45),('b',13),('c',12),('d',16),('e',9),('f',5)] ~?= [('a',"0"),('b',"101"),('c',"100"),('d',"111"),('e',"1101"),('f',"1100")]

    testsLogicAndCodes = TestList [
        testsExercise46{-,
        testExercise48-},
        testExercise49{-,
        testExericse50-}
        ]    

    main = runTestTT testsLogicAndCodes