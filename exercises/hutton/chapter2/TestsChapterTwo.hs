module TestsChapterTwo where
    import Test.HUnit
    import ChapterTwo

    testChapterTwoExercise3 = TestCase (assertEqual "for n" 2 n)
    testChapterTwoExercise4 = TestCase (assertEqual "for lastHead [1,2,3,4,5]" 5 (lastHead [1,2,3,4,5])) 
    testChapterTwoExercise5drop = TestCase (assertEqual "for initDrop [1,2,3,4]" [1,2,3,4] (initDrop [1,2,3,4,5])) 
    testChapterTwoExercise5tail = TestCase (assertEqual "for initTail [1,2,3,4]" [1,2,3,4] (initTail [1,2,3,4,5])) 

    testsChapterTwo = TestList [TestLabel "testChapterTwoExercise3" testChapterTwoExercise3, 
                                TestLabel "testChapterTwoExercise4" testChapterTwoExercise4,
                                TestLabel "testChapterTwoExercise5drop" testChapterTwoExercise5drop, 
                                TestLabel "testChapterTwoExercise5tail" testChapterTwoExercise5tail]