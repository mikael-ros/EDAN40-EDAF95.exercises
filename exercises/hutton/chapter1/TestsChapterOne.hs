module TestsChapterOne where
    -- This file does not currently compile --
    import Test.HUnit
    import ChapterOne

    testChapterOneExercise3 = TestCase (assertEqual 24 ChapterOne.product [2..4])
    testChapterOneExercise4 = TestCase (assertEqual [8,5,2,1] qsort [2,5,8,1]) 
    testChapterOneExercise5 = TestCase (assertEqual [1,2,3] qsortWrong [2,2,3,1,1]) 

    testsChapterOne = TestList [TestLabel "testExercise3" testChapterOneExercise3, 
                                TestLabel "testExercise4" testChapterOneExercise4, 
                                TestLabel "testExercise5" testChapterOneExercise5]