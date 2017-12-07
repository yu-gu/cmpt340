-- File Name: untilExample.hs
-- Original Author: Terence Huang
-- Modified By: David Kreiser
-- Class: CMPT 340 Tutorial 2

-- NB: Contains intentional bugs, see slide 12

-- Performs function newN until condition in myCheck evaluates to true
myFunction :: Int -> Int
myFunction n = until myCheck newN n
            where myCheck n = (n > 200)
                  newN n = if even n then n * 3 `div` 2 else n + 1


-- myCheck :: Int -> Bool
-- myCheck n = (n > 200)

-- newN :: Int -> Int
-- newN n = if even n then n * 3 `div` 2
-- 		else n + 1
