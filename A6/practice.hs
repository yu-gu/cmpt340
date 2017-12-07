-- File Name: practice.hs
-- Author: David Kreiser
-- Class: CMPT 340 Tutorial 6
-- Practice exercises to practice functional programming concepts

-- Exercise 1: multiplyLists takes two lists of doubles and multiplies each element of list1 with each element of list2
--multiplyLists :: [Integer] -> [Integer] -> [Integer]

multiplyLists :: [Integer]->[Integer]->[Integer]
multiplyLists list1 list2 = [x*y|x<-list1,y<-list2]

-- Main> multiplyLists [2,5,10] [8,10,11]
-- [16,20,22,40,50,55,80,100,110]

-- Exercise 2: removeUppercase removes all uppercase letters from a string 
--removeUppercase :: String -> String
  

-- Main> removeUppercase "iDONTlikelists"
-- "ilikelists"

-- Exercise 3: isPalindrome returns True if the list can be read forward or backward, False otherwise
--isPalindrome :: (Eq a) => [a] -> Bool

-- *Main> isPalindrome [1,2,3]
-- False
-- *Main> isPalindrome "madamimadam"
-- True
-- *Main> isPalindrome [1,2,4,8,16,8,4,2,1]
-- True


-- Exercise 4: compress removes repeated elements while maintaining the same order, keep only one copy
--compress :: (Eq a) => [a] -> [a]

-- *Main> compress "aaaabccaadeeee"
-- "abcade"

-- Exercise 5: insertAt inserts an element at a given position into a list
--insertAt :: a -> [a] -> Integer -> [a]

-- *Main> insertAt 'X' "abcd" 2
-- "aXbcd"

-- Exercise 6: myGCD finds the greatest common divisor of two positive integer numbers (Euclid’s algorithm)
--myGCD :: Integer -> Integer -> Integer

-- *Main> myGCD 36 63
-- 9

-- Exercise 7: fullWords takes an integer number and spells it out digit by digit, concatenated with a dash
--fullWords :: Integer -> String

-- *Main> fullWords 175
-- one-seven-five

-- Exercise 8: MyFraction is a datatype with one value where the Numerator and Denominator are represented by Integers.

-- 8a. Define the datatype


-- 8b. Implement the following operators    show    ==    >    +    negate    -    *    /


-- 8c. Implement the following functions    numerator    denominator    reciprocal    reduce

