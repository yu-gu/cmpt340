--sqrtPairs.hs
--Author: YU GU

sqrtPairs :: Float -> Float -> (Float,Float)
sqrtPairs a b =(sqrt a,sqrt b)
 


-----Another function
keepDoubling :: Integer -> Integer
keepDoubling n = until (>100) (*2) n
