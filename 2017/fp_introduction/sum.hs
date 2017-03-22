-- mysum
mysum :: [Int] -> Int
mysum [] = 0
mysum (x:xs) = x + mysum xs

main = do
    print $ mysum [1,2,3,4,5]
