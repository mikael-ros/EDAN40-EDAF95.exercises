module Tests where
    -- This file does not currently compile, package management is a f***ing nightmare in this language --
    import Test.HUnit
    import Exercise3
    import Exercise4
    import Exercise5

    testExercise3 = TestCase (assertEqual 24 Exercise3.product [2..4])
    testExercise4 = TestCase (assertEqual [8,5,2,1] Exercise4.qsort [2,5,8,1]) 
    testExercise5 = TestCase (assertEqual [1,2,3] Exercise5.qsort [2,2,3,1,1]) 
    tests = TestList [TestLabel "testExercise3" testExercise3, 
                      TestLabel "testExercise4" testExercise4, 
                      TestLabel "testExercise5" testExercise5]