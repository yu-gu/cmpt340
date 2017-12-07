-- Name: YU GU NSID:yug242 Student#:11195367

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