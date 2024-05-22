module TestsClassOneBasics where
    import Test.HUnit
    import ClassOneBasics
    import ClassOneLists
    
    ------------------
    -- -- Basics -- --
    ------------------

    testClassOneBasicsExercise1 = maxi 10 8 ~?= 10 

    testClassOneBasicsExercise2 =
        TestList [
            sumsq 3 ~?= 9 + 4 + 1,
            sumsqm 3 ~?= 9 + 4 + 1
        ]

    testClassOneBasicsExercise3 = hanoi 3 ~?= 7 -- Hanoi is 2*n - 1

    testClassOneBasicsExercise4 = 
        TestList [
            nextFactor 10 2 ~?= 2,
            smallestFactor 14 ~?= 2,
            smallestFactor 15 ~?= 3,
            removeDuplicates [2,2,1] ~?= [2,1],
            numFactors 10 ~?= 3
        ]

    testClassOneBasicsExercise5 = 
        TestList [
            daysInMonth ShortDate{year = 2024, month=4} ~?= 30,
            daysInMonth ShortDate{year = 2024, month=2} ~?= 29,
            daysInMonth ShortDate{year = 2023, month=2} ~?= 28,
            validDate Date{prefix = ShortDate{year = 2024, month=4}, day = 1} ~?= True,
            validDate Date{prefix = ShortDate{year = 2023, month=2}, day = 30} ~?= False
        ]
    
    testsClassOneBasics = 
        TestList [
            testClassOneBasicsExercise1,
            testClassOneBasicsExercise2,
            testClassOneBasicsExercise3,
            testClassOneBasicsExercise4,
            testClassOneBasicsExercise5
        ]

    ------------------------------------------------------------------------------------

    -----------------
    -- -- Lists -- --
    -----------------

    testClassOneListsExercise1 = multiply [1,2,3,4,5] ~?= 120
    
    testClassOneListsExercise2 = substitute 'e' 'i' "eigenvalue" ~?= "iiginvalui"

    testClassOneListsExercise3 = 
        TestList [
            duplicates [1,2,3,4,5] ~?= False,
            duplicates [1,2,3,2] ~?= True
        ]

    testsClassOneLists = 
        TestList [
            testClassOneListsExercise1,
            testClassOneListsExercise2,
            testClassOneListsExercise3
        ]

    ------------------------------------------------------------------------------------

    testsClassOne = TestList [
        testsClassOneBasics,
        testsClassOneLists
                            ]

    main = runTestTT testsClassOne