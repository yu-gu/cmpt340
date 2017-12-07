--Problem2
--Sample functions for testing
f1 x y = x+y
f2(x,y)= x-y

curry1 :: ((a,b) -> c) -> a -> b -> c
curry1 f = (\x y -> f(x,y))

uncurry1 :: (a -> b -> c) -> ((a, b) -> c)
uncurry1 f = (\(x,y) -> f x y)

--Problem3
data MyFloat = MyFloat(Integer,Integer)
        deriving (Show)

instance Eq MyFloat where
    (==) = compareMyFloat

compareMyFloat :: MyFloat -> MyFloat -> Bool
compareMyFloat (MyFloat(m1, e1)) (MyFloat(m2, e2)) = ((m1*(10^e1)) == (m2*(10^e2)))

instance Ord MyFloat where
         (MyFloat (a,b)) > (MyFloat (c,d)) = if(b>d)
                                             then True
                                             else if (b==d)
                                                then if (a>c)
                                                    then True
                                                else False
                                             else False
         (MyFloat (a,b)) >= (MyFloat (c,d)) = (MyFloat(a,b) > MyFloat(c,d)||MyFloat(a,b)==MyFloat(c,d))

         (MyFloat (a,b)) < (MyFloat (c,d)) = if(b<d)
                                             then True
                                             else if (b==d)
                                                then if (a<c)
                                                    then True
                                                else False
                                             else False
         (MyFloat (a,b)) <= (MyFloat (c,d)) = (MyFloat(a,b) < MyFloat(c,d)||MyFloat(a,b)==MyFloat(c,d))

instance Num MyFloat where
    (+) = addMyFloat
    (-) = minusMyFloat
    (*) = multMyFloat
    negate = negMyFloat
addMyFloat :: MyFloat -> MyFloat -> MyFloat
addMyFloat (MyFloat(m1, e1)) (MyFloat(m2, e2)) = if (e1 == e2)     then MyFloat((m1+m2), e1)
                                                 else if (e1 > e2) then MyFloat(((m1*10^(e1-e2))+m2), e1)
                                                 else                   MyFloat(((m2*10^(e2-e1))+m1), e2)

minusMyFloat :: MyFloat -> MyFloat -> MyFloat
minusMyFloat (MyFloat(m1, e1)) (MyFloat(m2, e2)) = if (e1 == e2)     then MyFloat((m1-m2), e1)
                                                 else if (e1 > e2) then MyFloat(((m1*10^(e1-e2))+m2), e1)
                                                 else                   MyFloat(((m2*10^(e2-e1))+m1), e2)
                                                 
multMyFloat :: MyFloat -> MyFloat -> MyFloat
multMyFloat (MyFloat(m1, e1)) (MyFloat(m2, e2)) = MyFloat((m1*m2), (e1+e2))

negMyFloat :: MyFloat -> MyFloat
negMyFloat (MyFloat(a, b)) = MyFloat(-a, b)

instance Fractional MyFloat where
    (/) = divMyFloat 
divMyFloat :: MyFloat -> MyFloat -> MyFloat
divMyFloat (MyFloat(a1, e1)) (MyFloat(a2, e2)) = MyFloat((a1`div`a2), (e1-e2+1))


removeZero :: Integer -> Integer
removeZero a | ((a) `mod` 10 == 0) = ((a) `div` 10)
             | otherwise       = a
--isInt x = x == fromInteger(round x)
--toInt a = until (isInt) (*10) a
between a = if(a>0 && a<1) then True else False  
todigit :: (Ord a, Fractional a) => a -> a
todigit a = until (between) (/10) a
value :: (Ord a, Fractional a) => MyFloat -> a
value (MyFloat(a,b)) = (todigit (fromIntegral a)) * (10^b)
whole :: MyFloat -> Integer
whole (MyFloat(a,b)) =  floor(value(MyFloat(a,b)))
fraction :: MyFloat -> Float
fraction (MyFloat (a,b)) = (value(MyFloat(a,b)))-fromInteger(whole(MyFloat(a,b)))

--Problem4
shuffle :: [a] -> [a] -> [a]
shuffle (x:xs) [] = (x:xs)
shuffle [] (y:ys) = (y:ys) 
shuffle [] [] = []
shuffle (x:xs) (y:ys) = x : y : shuffle xs ys

--Problem5

takeFirst :: (Num t1, Eq t1) => [t] -> t1 -> [t]
takeFirst [] _ = []
takeFirst _ 0 = [] 
takeFirst (x:xs) n = x : takeFirst xs (n-1)

takeSecond :: (Num t1, Eq t1) => [t] -> t1 -> [t]
takeSecond [] _ = []
takeSecond (x:xs) 0 = x:(takeSecond xs (0))
takeSecond (x:xs) n = takeSecond xs (n-1)


split :: (Num t, Eq t) => [t1] -> t -> ([t1], [t1])
split list n = (list1,list2)
              where list1 = takeFirst list n
                    list2 = takeSecond list n

--Problem6

split1 :: [Char]->([Char],[Char])
split1 list1 = (list3,list4)
  where list3 = takeFirst list1 ((length list1) `div` 2)
        list4 = takeSecond list1 ((length list1) `div` 2) 
        
makelist :: (Ord t1, Num t1) => t1 -> t -> [t]
makelist n _ | n <= 0 = []
makelist n a          = a : makelist (n-1) a

nshuffle :: Integer->Integer->[Char]      
nshuffle n c = add (list1,list2) n
  where list1 = makelist c 'b'
        list2 = makelist c 'r'
        add (list1,list2) n
         | n == 0    = (list1 ++ list2)
         | otherwise = add (split1 (shuffle list1 list2)) (n-1) 

--Problem7
makelist1 :: (Num t, Eq t1) => [t1] -> [t]
makelist1 []     = []
makelist1 (x:xs) = count 1 x xs 
  where count n x [] = [(n)]
        count n x (y:ys)   | x == y    = count (n + 1) x ys
                           | otherwise = (n) : count 1 y ys

findLargest :: Ord t => t -> [t] -> t
findLargest n [] = n
findLargest n (x:xs) = if (x>n) 
                       then findLargest x xs
                       else findLargest n xs

consecutive :: (Ord t, Num t, Eq t1) => [t1] -> t
consecutive []    = 0
consecutive list1 = k
  where k = findLargest 0 (makelist1 list1)    







