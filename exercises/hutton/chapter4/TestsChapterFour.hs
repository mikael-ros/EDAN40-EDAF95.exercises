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

    testChapterFourExercise5 = TestCase (assertEqual "for and' True && True" True (and' True True))
    testChapterFourExercise6 = TestCase (assertEqual "for and'' True && True" True (and'' True True))

    testChapterFourExercise7 = TestCase (assertEqual "for multLambda 1 2 3" 6 (multLambda 1 2 3))

    testChapterFourExercise8luhnDouble = TestCase (assertEqual "for luhnDouble 3" 6 (luhnDouble 3))
    testChapterFourExercise8luhnDoubleTwo = TestCase (assertEqual "for luhnDouble 6" 3 (luhnDouble 6))
    testChapterFourExercise8luhn = TestCase (assertEqual "for luhn 1 7 8 4" True (luhn 1 7 8 4))
    testChapterFourExercise8luhnTwo = TestCase (assertEqual "for luhn 4 7 8 3" False (luhn 4 7 8 3))

    testsChapterFour = TestList [
        TestLabel "testChapterFourExercise1" testChapterFourExercise1,
        TestLabel "testChapterFourExercise2Head" testChapterFourExercise2Head,
        TestLabel "testChapterFourExercise2Index" testChapterFourExercise2Index,
        TestLabel "testChapterFourExercise2Pattern" testChapterFourExercise2Pattern,
        TestLabel "testChapterFourExercise3Cond" testChapterFourExercise3Cond,
        TestLabel "testChapterFourExercise3Guard" testChapterFourExercise3Guard,
        TestLabel "testChapterFourExercise3Pattern" testChapterFourExercise3Pattern,
        TestLabel "testChapterFourExercise5" testChapterFourExercise5,
        TestLabel "testChapterFourExercise6" testChapterFourExercise6,
        TestLabel "testChapterFourExercise7" testChapterFourExercise7,
        TestLabel "testChapterFourExercise8luhnDouble" testChapterFourExercise8luhnDouble,
        TestLabel "testChapterFourExercise8luhnDoubleTwo" testChapterFourExercise8luhnDoubleTwo,
        TestLabel "testChapterFourExercise8luhn" testChapterFourExercise8luhn,
        TestLabel "testChapterFourExercise8luhnTwo" testChapterFourExercise8luhnTwo
                                ]