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

    testExercise25 = TestCase $ do
        randomPermutation <- rndPermu "abcdef"
        assertEqual "List should be different" True (randomPermutation /= "abcdef") -- again, cant test more than length really
    
    testExercise26 = length (combinations 3 "abcdef") ~?= 20 

    --testExercise27 = length (group [2,2,5] ["aldo","beat","carla","david","evi","flip","gary","hugo","ida"]) ~?= 756 (uncomment this if you have completed exercise 27)

    testsExercise28 = TestList [
        lsort ["abc","de","fgh","de","ijkl","mn","o"] ~?= ["o","de","de","mn","abc","fgh","ijkl"],
        lfsort ["abc", "de", "fgh", "de", "ijkl", "mn", "o"] ~?= ["ijkl","o","abc","fgh","de","de","mn"]
        ]

    testsListsAgain = TestList [
        testExercise21,
        testExercise22,
        testsExercise23,
        testExercise24,
        testExercise25,
        testExercise26{-,
        testExercise27 uncomment this too! -},
        testsExercise28
        ]    

    main = runTestTT testsListsAgain