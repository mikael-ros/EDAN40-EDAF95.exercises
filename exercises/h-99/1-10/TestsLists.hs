module TestsLists where
    import Test.HUnit
    import Lists

    testsExercise1 = TestList [
        myLast [1,2,3,4] ~?= 4,
        myLast' [1,2,3,4] ~?= 4
        ]

    testsExercise2 = TestList [
        myButLast [1,2,3,4] ~?= 3,
        myButLast' [1,2,3,4] ~?= 3
        ]

    testExercise3 = elementAt [1,2,3,4] 2 ~?= 2

    testsExercise4 = TestList [
        myLength [1,2,3,4] ~?= 4,
        myLength' [1,2,3,4] ~?= 4
        ]

    testsExercise5 = TestList [
        myReverse [1,2,3,4] ~?= [4,3,2,1],
        myReverse' [1,2,3,4] ~?= [4,3,2,1]
        ]

    testsExercise6 = TestList [
        slice [1,2,3,4] 1 3 ~?= [2,3,4],
        isPalindrome [1,2,3] ~?= False,
        isPalindrome "madamimadam" ~?= True,
        isPalindrome [1,2,4,8,16,8,4,2,1] ~?= True
        ]

    testExercise7 = myFlatten (List [Elem "a", List [Elem "b", List [Elem "c", Elem"d"], Elem "e"]]) ~?= ["a","b","c","d","e"]

    testExercise8 = compress "aaaabccaadeeee" ~?= "abcade"

    testExercise9 = pack "aaaabccaadeeee" ~?= ["aaaa","b","cc","aa","d","eeee"]

    testsExercise10 = TestList [
        encode "aaaabccaadeeee" ~?= [(4,'a'),(1,'b'),(2,'c'),(2,'a'),(1,'d'),(4,'e')],
        encode' "aaaabccaadeeee" ~?= [(4,'a'),(1,'b'),(2,'c'),(2,'a'),(1,'d'),(4,'e')]
        ]

    testsLists = TestList [
        testsExercise1,
        testsExercise2,
        testExercise3,
        testsExercise4,
        testsExercise5,
        testsExercise6,
        testExercise7,
        testExercise8,
        testExercise9,
        testsExercise10
        ]    

    main = runTestTT testsLists