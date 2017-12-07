--Name:YU GU StudentNumber:11195367 NSID:yug242
shuffle :: [a] -> [a] -> [a]
shuffle (x:xs) [] = (x:xs)
shuffle [] (y:ys) = (y:ys) 
shuffle [] [] = []
shuffle (x:xs) (y:ys) = x : y : shuffle xs ys