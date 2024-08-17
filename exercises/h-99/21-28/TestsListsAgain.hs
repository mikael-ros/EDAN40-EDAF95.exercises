module TestsListsAgain where
    import Test.HUnit
    import ListsAgain

    testExercise21 = insertAt 'X' "abcd" 2 ~?= "aXbcd"
    testExercise22 = range 4 9 ~?= [4,5,6,7,8,9]

    testExercise23_1 = TestCase $ do -- the actions are unsafe, so we need to wrap them in a do block
        randomList <- rndSelect "abcdefgh" 3
        assertEqual "Length should be 3" 3 (length randomList) -- we can't assert it is random, but we can atleast check it produces lists of the correct length
    
    testExercise23_2 = TestCase $ do -- test user input for more than the list length
        randomList <- rndSelect "abcdefgh" 9
        assertEqual "Length should be 8, even when supplied with n > length list" 8 (length randomList) 

    testsExercise23 = TestList [
        testExercise23_1,
        testExercise23_2
        ]

    testExercise24 = TestCase $ do
        randomList <- diffSelect 6 49
        assertEqual "Length of list should be 6" 6 (length randomList) -- again, cant test more than length really

    testsListsAgain = TestList [
        testExercise21,
        testExercise22,
        testsExercise23,
        testExercise24
        ]    

    main = runTestTT testsListsAgain