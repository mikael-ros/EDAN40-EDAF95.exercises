module TestsChapterFive where
    import Test.HUnit
    import ChapterFive

    testChapterFiveExercise1 = TestCase (assertEqual "for ?" ? (?))

    testsChapterFive = TestList [
        TestLabel "testChapterFiveExercise1" testChapterFiveExercise1
                                ]