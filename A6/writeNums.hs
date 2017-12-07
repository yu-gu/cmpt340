-- File Name: writeNums.hs
-- Author: David Kreiser
-- Class: CMPT 340 Tutorial 2

-- Example of using pattern matching rather than conditional statements or
-- guarded equations
writeNums :: Integer -> String  
writeNums 1 = "one"  
writeNums 2 = "two"  
writeNums 3 = "three"  
writeNums 4 = "four"  
writeNums x = "No other patterns matched"  
