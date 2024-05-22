module TestsClassTwo where
    import Test.HUnit
    import ClassTwoLogic

    testClassTwoLogicExercise1 = 0 ~?= 0

    testsClassTwoLogic = TestList [
        testClassTwoLogicExercise1
                            ]

    ------------------------------------------------------------------------------------

    testsClassTwo = TestList [
        testClassTwoLogic
                            ]

    main = runTestTT testsClassTwo