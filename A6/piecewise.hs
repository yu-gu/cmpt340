-- File Name: piecewise.hs
---- Author: Yu Gu

function :: Integer -> Integer
function x | x<1  		= x + 4
		   | x>=4 		= x - 5
		   | otherwise  = 2

--Alternate
fal :: Integer -> Integer
fal x   | x<1			=x + 4 
		| x>=4			=x - 5
		| otherwise		= 2