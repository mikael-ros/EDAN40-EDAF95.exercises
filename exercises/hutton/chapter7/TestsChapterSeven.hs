module TestsChapterSeven where
    import Test.HUnit
    import ChapterSeven
    
    testChapterSevenExercise1 =
        TestList [
            isEven 2 ~?= True,
            isEven 1 ~?= False,
            doubler 2 ~?= 4,
            doubleEvenNumbers [1,2,3,4,5,6] ~?= [4,8,12]
        ]

    testChapterSevenExercise2 =
        TestList [
            ChapterSeven.all isEven [2,4,8] ~?= True,
            ChapterSeven.all isEven [1,3,5] ~?= False,
            ChapterSeven.any isEven [1,2,5] ~?= True,
            ChapterSeven.any isEven [1,3,5] ~?= False,
            ChapterSeven.takeWhile isEven [2,4,6,7] ~?= [2,4,6],
            ChapterSeven.dropWhile isEven [2,4,6,7] ~?= [7]
        ]
    
    testChapterSevenExercise3 =
        TestList [
            map' isEven [2,4,5] ~?= [True, True, False],
            filter' isEven [2,4,5] ~?= [2,4]
        ]

    testChapterSevenExercise4 = dec2int [2,3,4,5] ~?= 2345
        
    testsChapterSeven = TestList [
         testChapterSevenExercise1,
         testChapterSevenExercise2,
         testChapterSevenExercise3,
         testChapterSevenExercise4
                                ]

    main = runTestTT testsChapterSeven