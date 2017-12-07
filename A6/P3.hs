data MyFloat = MyFloat (Integer,Integer)
  deriving Show
instance Eq MyFloat where
  (MyFloat (n,l)) == (MyFloat (m,p)) = ((removeZero(n)) == (removeZero(m)) && (l == p))
  (MyFloat (n,l)) /= (MyFloat (m,p)) = (n /= m || l /= p)
instance Ord MyFloat where
  (MyFloat (n,l)) > (MyFloat (m,p)) = if (l > p)
                                      then True
                                      else if (l == p)
                                      then
                                        if (removeZero(n)) > (removeZero(m))
                                        then True
                                        else False
                                      else False
  (MyFloat (n,l)) < (MyFloat (m,p)) = if (l < p)
                                      then True
                                      else if (l == p)
                                      then
                                        if (removeZero(n)) < (removeZero(m))
                                        then True
                                        else False
                                      else False
  (MyFloat (n,l)) >= (MyFloat (m,p)) = ((MyFloat (n,l)) == (MyFloat (m,p))) || (MyFloat (n,l)) > (MyFloat (m,p))
  (MyFloat (n,l)) <= (MyFloat (m,p)) = ((MyFloat (n,l)) == (MyFloat (m,p))) || (MyFloat (n,l)) < (MyFloat (m,p))
instance Num MyFloat where
  (MyFloat (n,l)) + (MyFloat (m,p)) = if ((removeZero(n))>=0 && (removeZero(m))>=0)
                                      then
                                        if (l == p)
                                        then MyFloat((addZero (min (removeZero(m)) (removeZero(n))) (getZeroNum (toInteger (min (removeZero(m)) (removeZero(n)))) (toInteger (max (removeZero(m)) (removeZero(n)))))+(max (removeZero(m)) (removeZero(n)))),l)
                                        else
                                          if ((MyFloat (n,l)) > (MyFloat (m,p)))
                                          then 
										    if ((removeZero(n))>(removeZero(m)))
											then MyFloat((addZero (removeZero(m)) (getZeroNum (min (removeZero(m)) (removeZero(n))) (max (removeZero(m)) (removeZero(n)))))+(addZero (removeZero(n)) (l-p)),l)
											else MyFloat((addZero (removeZero(n)) ((getZeroNum (min (removeZero(m)) (removeZero(n))) (max (removeZero(m)) (removeZero(n))))+(l-p)))+(removeZero(m)),l)
                                          else 
										    if ((removeZero(n))>(removeZero(m)))
											then MyFloat((addZero (removeZero(m)) ((getZeroNum (min (removeZero(m)) (removeZero(n))) (max (removeZero(m)) (removeZero(n))))+(p-l)))+(removeZero(n)),p)
											else MyFloat((addZero (removeZero(n)) (getZeroNum (min (removeZero(m)) (removeZero(n))) (max (removeZero(m)) (removeZero(n)))))+(addZero (removeZero(m)) (p-l)),p)
									  else if ((removeZero(n))>=0 && (removeZero(m)) <0)
                                      then (MyFloat (n,l)) - (MyFloat ((-m),p))
                                      else if ((removeZero(n))<0 && (removeZero(m))>=0)
                                      then (MyFloat (m,p)) - (MyFloat ((-n),l))
                                      else  negate (MyFloat ((-n),l)) + (MyFloat ((-m),p))								  
  (MyFloat (n,l)) - (MyFloat (m,p)) = if ((removeZero(n))>=0 && (removeZero(m)) >=0)
                                      then 
									    if (l == p)
                                        then MyFloat((addZero (removeZero(n)) (getZeroNum (min (removeZero(m)) (removeZero(n))) (max (removeZero(m)) (removeZero(n)))))-(removeZero(m)),l)
                                        else
                                          if ((MyFloat (n,l)) > (MyFloat (m,p)))
                                          then 
										    if ((removeZero(n))>(removeZero(m)))
											then MyFloat((addZero (removeZero(n)) (l-p)) - (addZero (removeZero(m)) (getZeroNum (min (removeZero(m)) (removeZero(n))) (max (removeZero(m)) (removeZero(n))))),l)
											else MyFloat((addZero n ((getZeroNum (min (removeZero(m)) (removeZero(n))) (max (removeZero(m)) (removeZero(n))))+(l-p)))-(removeZero(m)),l)
                                          else 
										    if ((removeZero(n))>(removeZero(m)))
											then MyFloat((removeZero(n))-(addZero (removeZero(m)) ((getZeroNum (min (removeZero(m)) (removeZero(n))) (max (removeZero(m)) (removeZero(n))))+(p-l))),p)
											else MyFloat((addZero (removeZero(n)) ((getZeroNum (min (removeZero(m)) (removeZero(n))) (max (removeZero(m)) (removeZero(n)))) - (addZero (removeZero(m)) (p-l)))),p)
									  else if ((removeZero(n))>=0 && (removeZero(m))<0)
                                      then (MyFloat (n,l)) + (MyFloat ((-m),p))
                                      else if ((removeZero(n))<0 && (removeZero(m))>=0)
                                      then negate ((MyFloat ((-n),l)) + (MyFloat (m,p)))
                                      else (MyFloat (n,l)) + (MyFloat ((-m),p))								  
  (MyFloat (n,l)) * (MyFloat (m,p)) = if((getZeroNum (removeZero(n)) (removeZero(m))) /= 0) 
                                        then
                                        if(((addZero (min (removeZero(m)) (removeZero(n))) (getZeroNum (fromIntegral(min (removeZero(m)) (removeZero(n)))) (fromIntegral(max (removeZero(m)) (removeZero(n))))))*(fromIntegral(max (removeZero(m)) (removeZero(n)))))>(10^(floor (logBase 10 (fromIntegral(max (removeZero(n)) (removeZero(m)) )))))) 
                                        then MyFloat(((addZero (min (removeZero(m)) (removeZero(n))) (getZeroNum (min (removeZero(m)) (removeZero(n))) (max (removeZero(m)) (removeZero(n))))*(max (removeZero(m)) (removeZero(n))))),(l+p))
					                    else MyFloat(((addZero (min (removeZero(m)) (removeZero(n))) (getZeroNum (min (removeZero(m)) (removeZero(n))) (max (removeZero(m)) (removeZero(n))))*(max (removeZero(m)) (removeZero(n))))),(l+p)-1)
                                      else 
									    if ((removeZero(n))*(removeZero(m)) > 10^(floor (logBase 10 (fromIntegral(max (removeZero(n)) (removeZero(m)))))))
                                        then MyFloat((removeZero(n))*(removeZero(m)),(l+p))
                                        else MyFloat((removeZero(n))*(removeZero(m)),(l+p-l))										
  negate (MyFloat (n,l))            = MyFloat (0 - (removeZero(n)),l) 
instance Fractional MyFloat where
  (MyFloat (n,l)) / (MyFloat (m,p)) =  converterback(value(MyFloat ((removeZero(n),l)))/value(MyFloat ((removeZero(m),p))))

--min2 :: (Fractional Integral a)-> Fractional Integral-> Fractional Integral  
--min2 a b = if (a>b) then a else b  
getZeroNum a b = floor (logBase 10 (fromIntegral b)) - floor (logBase 10 (fromIntegral a))									   
addZero a b = a * (10**b)
removeZero :: Integer -> Integer
removeZero a | ((a) `mod` 10 == 0) = ((a) `div` 10)
             | otherwise       = a								   									 							    
between :: (Ord a, Num a) => a -> Bool
between a = if(a>0 && a<1) then True else False  
flow :: (Ord a, Fractional a) => a -> a
flow a = until (between) (/10) a
value :: MyFloat -> Float
value (MyFloat (a,b)) = (fromInteger((flow (fromIntegral(a))) * (toInteger(10**b))))
whole :: MyFloat -> Integer
whole (MyFloat (a,b)) = floor (value (MyFloat (a,b)))
fraction :: MyFloat -> Float
fraction (MyFloat (a,b)) = (value (MyFloat (a,b))) -  fromInteger (whole (MyFloat (a,b)))
converter :: MyFloat -> (Integer,Float)
converter (MyFloat (a,b)) = (x,y)
  where x = floor (value (MyFloat (a,b)))
        y = (value (MyFloat (a,b))) - fromInteger x
isInt :: RealFrac a => a -> Bool
isInt x = x == fromInteger (round x)
reflow a = floor (reflow2 a)
reflow2 :: RealFrac a => a -> a
reflow2 a = until (isInt) (*10) a
flowing a | a < 10    = 1
          | otherwise = flowing (a/10)+1
folwing a | (a>1) = 1
          | otherwise = folwing (a*10)-1 		  
converterback a = MyFloat(x,y)
  where x = reflow a
        y | (a<1) = folwing a
          | otherwise = flowing a 		