module TestsChapterOne where
    -- This file does not currently compile --
    import Test.HUnit
    import ChapterOne

    testChapterOneExercise3 = TestCase (assertEqual "The product should be" 24 (ChapterOne.product [2..4]))
    testChapterOneExercise4 = TestCase (assertEqual "The sorted list should be" [8,5,2,1] (qsortReversed [2,5,8,1])) 
    testChapterOneExercise5 = TestCase (assertEqual "The incorrect output should be" [1,2,3] (qsortWrong [2,2,3,1,1])) 

    testsChapterOne = TestList [TestLabel "testChapterOneExercise3" testChapterOneExercise3, 
                                TestLabel "testChapterOneExercise4" testChapterOneExercise4, 
                                TestLabel "testChapterOneExercise5" testChapterOneExercise5]