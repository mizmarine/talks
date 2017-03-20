twice :: (Int -> Int) -> Int -> Int
twice f x = f (f x)

addThree :: Int -> Int
addThree x = x + 3

mulTwo :: Int -> Int
mulTwo x = x * 2
