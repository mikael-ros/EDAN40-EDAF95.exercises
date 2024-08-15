module TestsClassTwo where
    import Test.HUnit
    import ClassTwo

    states = [
        ("jimmy", True),
        ("bobby", False)
        ]

    -- https://www.youtube.com/watch?v=aYIAynSM7ZI
    testFileSystem = Directory "blink-182" [
        File "Spongebob",
        Directory "Patrick" [Directory "Squidward" [File "Sandy"]],
        File "Larry",
        Directory "Pearl" [Directory "Mr.Krabs" [File "Plankton"]]
        ]

    testsClassTwoLogic = TestList [
        vars (Variable "jimmy") ~?= ["jimmy"],
        vars (Variable "jimmy" :/\: Variable "bobby") ~?= ["jimmy", "bobby"],
        vars (Variable "jimmy" :\/: Variable "bobby") ~?= ["jimmy", "bobby"],
        vars (Not (Variable "jammy")) ~?= ["jammy"],
        truthValue (Variable "jimmy") states ~?= True,
        truthValue (Variable "jimmy" :/\: Variable "bobby") states ~?= False,
        truthValue (Variable "jimmy" :\/: Variable "bobby") states ~?= True,
        truthValue (Not (Variable "jimmy")) states ~?= False,
        truthValue (Not (Variable "bobby")) states ~?= True,
        tautology (Variable "jimmy") ~?= False,
        tautology (Not (Variable "bobby")) ~?= False,
        tautology (Variable "jimmy" :\/: Not(Variable "jimmy")) ~?= True,
        tautology (Variable "bobby" :/\: Variable "jimmy") ~?= False
        ]

    testsClassTwoFiles = TestList [
        search "Spongebob" [] testFileSystem ~?= Just ["blink-182","Spongebob"],
        search "Plankton" [] testFileSystem ~?= Just ["blink-182","Pearl","Mr.Krabs","Plankton"],
        search "Gary" [] testFileSystem ~?= Nothing,
        printPath ["blink-182","Pearl","Mr.Krabs","Plankton"] ~?= "blink-182/Pearl/Mr.Krabs/Plankton"
        ]

    testsClassTwoSets = TestList [
        
        ]    
    ------------------------------------------------------------------------------------

    testsClassTwo = TestList [
        testsClassTwoLogic,
        testsClassTwoFiles,
        testsClassTwoSets
                            ]

    main = runTestTT testsClassTwo