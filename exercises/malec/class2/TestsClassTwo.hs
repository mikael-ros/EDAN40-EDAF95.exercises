module TestsClassTwo where
    import Test.HUnit
    import ClassTwo

    testClassTwoExercise1 = 0 ~?= 0

    ------------------------------------------------------------------------------------

    testsClassTwo = TestList [
        testClassTwoExercise1
                            ]

    main = runTestTT testsClassTwo