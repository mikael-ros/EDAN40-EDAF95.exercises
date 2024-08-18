module TestsArithmetic where
    import Test.HUnit
    import Arithmetic

    testExercise31 = isPrime 7 ~?= True

    testsExercise32 = TestList [
        myGCD 36 63 ~?= 9,
        myGCD (-3) (-6) ~?= 3,
        myGCD (-3) 6 ~?= 3
        ]

    testExercise33 = coprime 35 64 ~?= True

    testExercise34 = totient 10 ~?= 4

    testsExercise35 = TestList [
        primeFactors 315 ~?= [3,3,5,7],
        primeFactors' 315 ~?= [3,3,5,7]
        ]

    testExercise36 = primeFactorsMult 315 ~?= [(3,2),(5,1),(7,1)]

    testExercise37 = totientImproved 10 ~?= 4

    testExercise39 = primesR 10 20 ~?= [11,13,17,19]

    testExercise40 = goldbach 28 ~?= (5,23)

    testsArithmetic = TestList [
        testExercise31,
        testsExercise32,
        testExercise33,
        testExercise34,
        testsExercise35,
        testExercise36,
        testExercise37,
        testExercise39,
        testExercise40
        ]    

    main = runTestTT testsArithmetic