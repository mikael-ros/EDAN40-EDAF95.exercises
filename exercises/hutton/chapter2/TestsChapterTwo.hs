module TestsChapterTwo where
    -- This file does not currently compile --
    import Test.HUnit
    import ChapterTwo

    testChapterTwoExercise3 = TestCase (assertEqual "n returns" 2 n)
    testChapterTwoExercise4 = TestCase (assertEqual "lastHead grabs last element" 5 (lastHead [1,2,3,4,5])) 
    testChapterTwoExercise5drop = TestCase (assertEqual "initDrop removes last element" [1,2,3,4] (initDrop [1,2,3,4,5])) 
    testChapterTwoExercise5tail = TestCase (assertEqual "initTail removes last element" [1,2,3,4] (initTail [1,2,3,4,5])) 

    testsChapterTwo = TestList [TestLabel "testChapterTwoExercise3" testChapterTwoExercise3, 
                                TestLabel "testChapterTwoExercise4" testChapterTwoExercise4,
                                TestLabel "testChapterTwoExercise5drop" testChapterTwoExercise5drop, 
                                TestLabel "testChapterTwoExercise5tail" testChapterTwoExercise5tail]