-- This is just me experimenting with functors and monads
data Box a = Box {content :: a, label :: String} | Warehouse {boxes :: [Box a], name :: String}

instance Show a => Show (Box a) where 
    show :: Box a -> String
    show (Box content label) = label ++ " box contains " ++ show content
    show (Warehouse boxes name) = "The " ++ name ++ " warehouse contains the following boxes: \n" ++ (concatMap (\b -> " - " ++ (show b) ++ "\n") boxes)

instance Functor Box where
    fmap :: (a -> b) -> Box a -> Box b
    fmap fn (Box content label) = Box (fn content) label
    fmap fn (Warehouse boxes name) = Warehouse (map (fmap fn) boxes) name

doubleContent :: Int -> Int -- a little test method to test the functor
doubleContent = (*2)

instance Applicative Box where 
    pure :: a -> Box a
    pure a = Box a ""

    (<*>) :: Box (a -> b) -> Box a -> Box b
    (Box fn l1) <*> (Box content l2) = Box (fn content) (l1++l2)
    (Box fn l1) <*> (Warehouse content name) = Warehouse (map (fmap fn) content) (l1++name)
    (Warehouse fs name) <*> bx@(Box _ _) = Warehouse (map (<*> bx) fs) name
    (Warehouse fs n1) <*> (Warehouse content n2) = Warehouse (zipWith (<*>) fs content) (n1++n2)

instance Monad Box where 
    (>>=) :: Box a -> (a -> Box b) -> Box b
    (Box content label) >>= f = 
        let (Box newContent newLabel) = f content
        in Box newContent (label ++ " and then " ++ newLabel)

    (Warehouse boxes name) >>= f = 
        Warehouse (map (>>= f) boxes) ("Result of " ++ name)