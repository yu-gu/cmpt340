-- File Name: quad.hs
-- Original code: CMPT 340 "01 Simple Haskell" Slides Page 36
-- Modified by: David Kreiser
-- Class: CMPT 340 Tutorial 2

-- Example of using guarded equations
quad1 :: Double -> Double -> Double -> Double
quad1 a b c | a == 0    = error "not quadratic"
            | disc < 0  = error "not real"
            | otherwise = (-b + (sqrt disc))/(2* a)
            where disc = b * b - 4 * a * c

-- Example of using conditional statements
quad2 :: Double -> Double -> Double -> Double
quad2 a b c = if (a == 0) then (error "not quadratic")
              else if (disc < 0) then (error "not real")
              else ((-b + (sqrt disc))/(2 * a))
              where disc = b * b - 4 * a * c

-- Example of using pattern matching
quad3 :: Double -> Double -> Double -> Double
quad3 0 b c = error "not quadratic"
quad3 a b c | disc < 0  = error "not real"
            | otherwise = (-b + (sqrt disc))/(2 * a)
            where disc  = b * b - 4 * a * c
