module ClassTwo where
    import Data.Maybe
    -------------------------------------------
    -- || -- -- Propositional logic -- -- || --
    -------------------------------------------

    ----------------------
    -- -- Exercise 1 -- --
    ----------------------
    data Proposition = 
        Variable String
        | Proposition :/\: Proposition
        | Proposition :\/: Proposition 
        | Not Proposition
    {-
       Note that the stuff wrapped by : : are definitions for 
       our own infix operators. Since I'm special, 
       I chose some rather annoying one :)
    -}

    ----------------------
    -- -- Exercise 2 -- --
    ----------------------
    -- vars
    vars :: Proposition -> [String]
    vars (Variable string)  = [string]
    vars (p :/\: q)         = vars p ++ vars q
    vars (p :\/: q)         = vars p ++ vars q
    vars (Not p)            = vars p

    -- truthValue
    truthValue :: Proposition -> [(String,Bool)] -> Bool
    truthValue (Variable string)    = fromJust . lookup string
    truthValue (p :/\: q)           = \states -> 
        truthValue p states && truthValue q states 
    truthValue (p :\/: q)           = \states -> 
        truthValue p states || truthValue q states 
    truthValue (Not p)              = not . truthValue p

    ----------------------
    -- -- Exercise 3 -- --
    ----------------------
    genTruthTable :: [String] -> [[(String, Bool)]]
    genTruthTable [] = [[]]
    genTruthTable (v:vs) = [(v,bool):combs | combs <- genTruthTable vs, bool <- [True,False]]

    tautology :: Proposition -> Bool 
    tautology (Variable string) = False -- Base cases, these will never be tautologies
    tautology (Not p) = False
    tautology p = and [truthValue p table | table <- genTruthTable (vars p)]

    ------------------------------------
    -- || -- -- File systems -- -- || --
    ------------------------------------

    ----------------------
    -- -- Exercise 1 -- --
    ----------------------
