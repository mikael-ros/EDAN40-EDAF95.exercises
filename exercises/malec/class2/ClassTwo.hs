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
    data File = File String | Directory String [File]
        deriving (Eq, Show)
    type Path = [String]

    ----------------------
    -- -- Exercise 2 -- --
    ----------------------
    search :: String -> Path -> File -> Maybe Path
    search query path (File fileName) 
        | fileName == query = Just (path++[fileName])
        | otherwise = Nothing
    search query path (Directory dirName files)
        | dirName == query = Just (path++[dirName])
        | otherwise = head (filter isJust (map (search query (path++[dirName])) files)++[Nothing]) -- Nothing will be head if there are no "Justs"

    printPath :: Path -> String
    printPath = foldr1 (\path file -> path++"/"++file)
    
    ----------------------------
    -- || -- -- Sets -- -- || --
    ----------------------------

    ----------------------
    -- -- Exercise 1 -- --
    ----------------------
    data Set t = Set [t]
        deriving (Show)

        

    emptySet :: Set t
    emptySet = Set []

    listToSet :: Eq t => [t] -> Set t
    listToSet list = Set (removeDuplicates list)

    removeDuplicates :: Eq t => [t] -> [t]
    removeDuplicates [] = []
    removeDuplicates [e] = [e]
    removeDuplicates (l:ls) = l:filter (/= l) (removeDuplicates ls)

    union :: Set t -> Set t -> Set t 
    union s1 s2 = Set (s1 ++ s2)

    setHas :: Eq t => t -> Set t -> Bool
    setHas query s = s includes query
