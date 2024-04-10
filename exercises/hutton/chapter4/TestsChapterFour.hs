module TestsChapterFour where
    import Test.HUnit
    import ChapterFour

    testChapterFourExercise1 = TestCase (assertEqual "for halve [1,2,3,4,5,6]" [1,2,3] (halve [1,2,3,4,5,6]))

    testChapterFourExercise2Head = TestCase (assertEqual "for thirdHead in [1,2,3,4,5,6]" 3 (thirdHead [1,2,3,4,5,6]))
    testChapterFourExercise2Index = TestCase (assertEqual "for thirdIndex in [1,2,3,4,5,6]" 3 (thirdIndex [1,2,3,4,5,6]))
    testChapterFourExercise2Pattern = TestCase (assertEqual "for thirdPattern in [1,2,3,4,5,6]" 3 (thirdPattern [1,2,3,4,5,6]))

    -- I can't test the empty lists, so these tests are kind of redundant --
    testChapterFourExercise3Cond = TestCase (assertEqual "for safetailCond [1,2,3,4,5,6]" [2,3,4,5,6] (safetailCond [1,2,3,4,5,6]))
    testChapterFourExercise3Guard = TestCase (assertEqual "for safetailCond [1,2,3,4,5,6]" [2,3,4,5,6] (safetailGuard [1,2,3,4,5,6]))
    testChapterFourExercise3Pattern = TestCase (assertEqual "for safetailCond [1,2,3,4,5,6]" [2,3,4,5,6] (safetailPattern [1,2,3,4,5,6]))

    testsChapterFour = TestList [
        TestLabel "testChapterFourExercise1" testChapterFourExercise1,
        TestLabel "testChapterFourExercise2Head" testChapterFourExercise2Head,
        TestLabel "testChapterFourExercise2Index" testChapterFourExercise2Index,
        TestLabel "testChapterFourExercise2Pattern" testChapterFourExercise2Pattern,
        TestLabel "testChapterFourExercise3Cond" testChapterFourExercise3Cond,
        TestLabel "testChapterFourExercise3Guard" testChapterFourExercise3Guard,
        TestLabel "testChapterFourExercise3Pattern" testChapterFourExercise3Pattern
                                ]