
--Author:YU GU
seq1 :: Integer -> Integer
seq1 n = if (n==1)             then 1
         else if (n `mod` 2 ==1)    then 1+seq1(3 * n + 1)
         else                          1+seq1( n `div` 2 )

--
seq2 :: Integer -> Integer
seq2 n | n==1               =1
       | (n `mod` 2 == 1)   =1 + seq2( 3 * n + 1) 
       | (n `mod` 2 == 0)   =1 + seq2( n `div` 2)


--
seq3 :: Integer -> Integer
seq3 1 = 1
seq3 n = oddOrEven (n `mod` 2)
     where oddOrEven 1 = 1 + seq3(3 * n +1)
           oddOrEven 0 = 1 + seq3(n `div` 2)