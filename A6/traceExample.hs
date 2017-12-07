-- File Name: writeNums.hs
-- Author: David Kreiser
-- Class: CMPT 340 Tutorial 2

-- Related to slide 11

-- import required for use of trace
import Debug.Trace

-- Note the type signature for trace
-- trace :: String -> a -> a

-- Calculates the factorial of an integer, prints debugging information while calculating
factorial :: Int -> Int
factorial 0 = 1
factorial n = trace ("n = " ++ show n) (n * factorial (n - 1))


-- Doubles the input until the result is greater than 100
-- Prints debugging information
keepDoubling :: Integer -> Integer
keepDoubling n = until (>100) (timesTwo) n 
    where timesTwo a = trace ("a = " ++ show a) (2*a)
    
-- Standard definition of The Fibonacci Sequence
fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = trace ("n = " ++ show n) (fib (n-1) + fib (n-2))
