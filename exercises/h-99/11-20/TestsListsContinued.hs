module TestsListsContinued where
    import Test.HUnit
    import ListsContinued

    testExercise11 = encodeModified "aaaabccaadeeee" ~?=    [Multiple 4 'a', 
                                                            Single 'b', 
                                                            Multiple 2 'c',
                                                            Multiple 2 'a',
                                                            Single 'd',
                                                            Multiple 4 'e']
    
    testExercise12 = decode [Multiple 4 'a', 
                            Single 'b', 
                            Multiple 2 'c',
                            Multiple 2 'a',
                            Single 'd',
                            Multiple 4 'e'] ~?= "aaaabccaadeeee"

    testExercise13 = encodeDirect "aaaabccaadeeee" ~?= [Multiple 4 'a', 
                                                        Single 'b', 
                                                        Multiple 2 'c',
                                                        Multiple 2 'a',
                                                        Single 'd',
                                                        Multiple 4 'e']
    
    testExercise14 = dupli [1,2,3] ~?= [1,1,2,2,3,3]

    testExercise15 = repli "abc" 3 ~?= "aaabbbccc"

    testsExercise16 = TestList [
        dropEvery "abcdefghik" 3 ~?= "abdeghk",
        dropEvery' "abcdefghik" 3 ~?= "abdeghk"
        ]

    testsExercise17 = TestList [
        split "abcdefghik" 3 ~?= ("abc", "defghik"),
        split' "abcdefghik" 3 ~?= ("abc", "defghik")
        ]

    testExercise18 = slice "abcdefghik" 3 7 ~?= "cdefg"

    testsExercise19 = TestList [
        rotate "abcdefgh" 3 ~?= "defghabc",
        rotate "abcdefgh" (-2) ~?= "ghabcdef"
        ]

    testsExercise20 = TestList [
        removeAt 2 "abcd" ~?= ('b', "acd"),
        removeAt' 2 "abcd" ~?= ('b', "acd")
        ]
        
    testsListsContinued = TestList [
        testExercise11,
        testExercise12,
        testExercise13,
        testExercise14,
        testExercise15,
        testsExercise16,
        testsExercise17,
        testExercise18,
        testsExercise19,
        testsExercise20
        ]    

    main = runTestTT testsListsContinued