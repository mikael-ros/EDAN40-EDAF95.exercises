module TestsChapterSix where
    import Test.HUnit
    import ChapterSix

    testChapterSixExercise1 = TestCase (assertEqual "for facFixed -1" 0 (facFixed (-1)))
    testChapterSixExercise2 = TestCase (assertEqual "for sumdown 3" 6 (sumdown 3))
    testChapterSixExercise3 = TestCase (assertEqual "for power 2 3" 8 (power 2 3))

    testChapterSixExercise4 = TestCase (assertEqual "for euclid 6 27" 3 (euclid 6 27))

    testChapterSixExercise6and = TestCase (assertEqual "for and [True,True,True]" True (ChapterSix.and [True,True,True]))
    testChapterSixExercise6and2 = TestCase (assertEqual "for and [True,False,True]" False (ChapterSix.and [True,False,True]))
    testChapterSixExercise6concat = TestCase (assertEqual "for concat [[1,2], [3,4], [5,6]]" [1,2,3,4,5,6] (ChapterSix.concat [[1,2], [3,4], [5,6]]))
    testChapterSixExercise6replicate = TestCase (assertEqual "for replicate 3 6" [6,6,6] (ChapterSix.replicate 3 6))
    testChapterSixExercise6get = TestCase (assertEqual "for !! [1,2,3] 2" 3 ((ChapterSix.!!) [1,2,3] 2))
    testChapterSixExercise6elem = TestCase (assertEqual "for elem 2 [1,2,3]" True (ChapterSix.elem 2 [1,2,3]))
    testChapterSixExercise6elem2 = TestCase (assertEqual "for elem 4 [1,2,3]" False (ChapterSix.elem 4 [1,2,3]))


    testsChapterSix = TestList [
        TestLabel "testChapterSixExercise1" testChapterSixExercise1,
        TestLabel "testChapterSixExercise2" testChapterSixExercise2,
        TestLabel "testChapterSixExercise3" testChapterSixExercise3,
        TestLabel "testChapterSixExercise4" testChapterSixExercise4,
        TestLabel "testChapterSixExercise6and" testChapterSixExercise6and,
        TestLabel "testChapterSixExercise6and2" testChapterSixExercise6and2,
        TestLabel "testChapterSixExercise6concat" testChapterSixExercise6concat,
        TestLabel "testChapterSixExercise6replicate" testChapterSixExercise6replicate,
        TestLabel "testChapterSixExercise6get" testChapterSixExercise6get,
        TestLabel "testChapterSixExercise6elem" testChapterSixExercise6elem,
        TestLabel "testChapterSixExercise6elem2" testChapterSixExercise6elem2
                                ]