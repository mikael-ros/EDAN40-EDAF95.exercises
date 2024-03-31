module Tests where
    -- This file does not currently compile --
    import Test.HUnit
    import ChapterOne

    testExercise3 = TestCase (assertEqual 24 ChapterOne.product [2..4])
    testExercise4 = TestCase (assertEqual [8,5,2,1] qsort [2,5,8,1]) 
    testExercise5 = TestCase (assertEqual [1,2,3] qsortWrong [2,2,3,1,1]) 
    tests = TestList [TestLabel "testExercise3" testExercise3, 
                      TestLabel "testExercise4" testExercise4, 
                      TestLabel "testExercise5" testExercise5]