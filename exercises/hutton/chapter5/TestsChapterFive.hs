module TestsChapterFive where
    import Test.HUnit
    import ChapterFive

    testChapterFiveExercise1 = TestCase (assertEqual "for hundredSquares" 338350 hundredSquares)

    testChapterFiveExercise2 = TestCase (assertEqual "for grid 1 2" [(0,0),(0,1),(0,2),(1,0),(1,1),(1,2)] (grid 1 2))
    testChapterFiveExercise3 = TestCase (assertEqual "for square 2" [(0,1),(0,2),(1,0),(1,2),(2,0),(2,1)] (square 2))

    testChapterFiveExercise4 = TestCase (assertEqual "for replicate 3 True" [True, True, True] (ChapterFive.replicate 3 True))

    testChapterFiveExercise5 = TestCase (assertEqual "for pyths 10" [(3,4,5),(4,3,5),(6,8,10),(8,6,10)] (pyths 10))

    testChapterFiveExercise6 = TestCase (assertEqual "for perfects 500" [6,28,496] (perfects 500))

    testChapterFiveExercise7 = TestCase (assertEqual "for seperateGenerators" [1,2,3,4] seperateGenerators)

    testsChapterFive = TestList [
        TestLabel "testChapterFiveExercise1" testChapterFiveExercise1,
        TestLabel "testChapterFiveExercise2" testChapterFiveExercise2,
        TestLabel "testChapterFiveExercise3" testChapterFiveExercise3,
        TestLabel "testChapterFiveExercise4" testChapterFiveExercise4,
        TestLabel "testChapterFiveExercise5" testChapterFiveExercise5,
        TestLabel "testChapterFiveExercise6" testChapterFiveExercise6,
        TestLabel "testChapterFiveExercise7" testChapterFiveExercise7
                                ]