twice :: (Int -> Int) -> Int -> Int
twice f x = f (f x)

addThree :: Int -> Int
addThree x = x + 3

mulTwo :: Int -> Int
mulTwo x = x * 2

mymap :: (a -> b) -> [a] -> [b]
mymap f as = foldr step [] as
  where
    step a acc = f a : acc

myfilter :: (a -> Bool) -> [a] -> [a]
myfilter f as = foldr step [] as
  where
    step a acc
      | f a = a : acc
      | otherwise = acc
