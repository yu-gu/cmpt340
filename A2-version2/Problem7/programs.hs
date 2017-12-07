--Name:YU GU StudentNumber:11195367 NSID:yug242
makelist :: (Num t, Eq t1) => [t1] -> [t]
makelist []     = []
makelist (x:xs) = count 1 x xs 
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
  where k = findLargest 0 (makelist list1)      