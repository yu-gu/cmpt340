-- File Name: typeExamples.hs
-- Author: David Kreiser
-- Class: CMPT 340 Tutorial 4

-- Example of using type keyword to create a type synonym
type ThreeInts = (Int, Int, Int)

averageThree :: ThreeInts -> Double
averageThree (x,y,z) = (fromIntegral (x+y+z))/3



-- Example of using data keyword to create a new data type
data Floor = Ground | First | Second

checkFloor :: Floor -> String
checkFloor Ground = "We are on ground floor"
checkFloor First = "We are on first floor"
checkFloor Second = "We are on second floor"



-- Example of a polymorphic function
compose2 :: (a -> a) -> (a -> a) -> a -> a
compose2 f g x = f(g(x))

mult2Int :: Int -> Int
mult2Int x = x * 2

add2Double :: Double -> Double
add2Double x = x + 2.6



-- Another example using data keyword
-- Example from https://www.schoolofhaskell.com/user/byorgey/introduction-to-haskell/2-algebraic-data-types
data FailableDouble = Failure 
                    | OK Double
  deriving Show
  
safeDiv :: Double -> Double -> FailableDouble
safeDiv _ 0 = Failure
safeDiv x y = OK (x / y)

-- Sample calls to safeDiv:
--      safeDiv 2 0
--      safeDiv 3 4



-- A third example using data keyword
-- Example from https://www.schoolofhaskell.com/user/byorgey/introduction-to-haskell/2-algebraic-data-types
data Thing = Shoe
           | Ship
           | Cannonball
           | Cabbage
           | King
  deriving Show
  
-- Store a person's name, age, and favorite Thing
data Person = Person String Int Thing
  deriving Show
--Notice how the type constructor and data constructor are both named Person, but they inhabit 
--different namespaces and are different things. This idiom (giving the type and data constructor 
--of a one-constructor type the same name) is common, but can be confusing until you get used to it.

brent :: Person
brent = Person "Brent" 30 Cannonball

stan :: Person
stan = Person "Stan" 94 Cabbage

getAge :: Person -> Int
getAge (Person _ a _) = a

-- Sample calls to getAge
--      getAge stan
--      getAge brent
