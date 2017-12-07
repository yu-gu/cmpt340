-- unfold function provided in assignment 3 description

-- p: a partial predicate
-- h: a partial function which generates the head
-- t: a partial function which generates the tail
-- x: an argument to apply to the above partial predicate/functions

--    returns an empty list if the partial predicate p is true when applied to the argument x
--    returns a non-empty list by applying the partial function h to x to create the head
--        and the partial function t to generate the next item to be recursively processed as 
--        the tail
unfold :: (a -> Bool) -> (a -> b) -> (a -> a) -> a -> [b]
unfold p h t x | p x = []
               | otherwise = (h x):(unfold p h t (t x))
               
               
-- Uses unfold to return a binary representation of the given integer
-- Note the binary number produced is reversed - how can we fix this?
int2bin :: Integer -> [Integer]
int2bin = unfold (==0) (`mod` 2) (`div` 2)

-- Solution: call reverse on the result of int2bin
int2bin2 :: Integer -> [Integer]
int2bin2 x = reverse (int2bin x)

myZipwith :: (a->b->c)->[a]->[b]->[c]
myZipwith _ [] _ = []
myZipwith _ _ [] = []
myZipwith f (x:xs) (y:ys) = f x y : myZipwith f xs ys