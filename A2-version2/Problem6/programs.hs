-- Name: YU GU NSID:yug242 Student#:11195367

takeFirst :: (Num t1, Eq t1) => [t] -> t1 -> [t]
takeFirst [] _ = []
takeFirst _ 0 = [] 
takeFirst (x:xs) n = x : takeFirst xs (n-1)

takeSecond :: (Num t1, Eq t1) => [t] -> t1 -> [t]
takeSecond [] _ = []
takeSecond (x:xs) 0 = x:(takeSecond xs (0))
takeSecond (x:xs) n = takeSecond xs (n-1)

split :: [Char]->([Char],[Char])
split list1 = (list3,list4)
  where list3 = takeFirst list1 ((length list1) `div` 2)
        list4 = takeSecond list1 ((length list1) `div` 2) 
        
shuffle :: [a] -> [a] -> [a]
shuffle (x:xs) [] = (x:xs)
shuffle [] (y:ys) = (y:ys) 
shuffle [] [] = []
shuffle (x:xs) (y:ys) = x : y : shuffle xs ys

makelist :: (Ord t1, Num t1) => t1 -> t -> [t]
makelist n _ | n <= 0 = []
makelist n a          = a : makelist (n-1) a

nshuffle :: Integer->Integer->[Char]      
nshuffle n c = add (list1,list2) n
  where list1 = makelist c 'b'
        list2 = makelist c 'r'
        add (list1,list2) n
         | n == 0    = (list1 ++ list2)
         | otherwise = add (split (shuffle list1 list2)) (n-1)  

  
