module TestsClassTwo where
    import Test.HUnit
    import ClassTwo

    states = [
        ("jimmy", True),
        ("bobby", False)
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
        tautology (Variable "bobby" :/\: Variable "jimmy") ~?= False,
        ]

    ------------------------------------------------------------------------------------

    testsClassTwo = TestList [
        testsClassTwoLogic
                            ]

    main = runTestTT testsClassTwo