--Name:YU GU StudentNumber:11195367 NSID:yug242

--type mantissa1 = Integer
--type exponent1 = Integer

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