-- function
doubleMe :: Int -> Int
doubleMe x = x * 2

-- pattern match
weekday :: Int -> String
weekday 0 = "Sunday"
weekday 1 = "Monday"
weekday 2 = "Tuesday"
weekday 3 = "Wednesday"
weekday 4 = "Thursday"
weekday 5 = "Friday"
weekday 6 = "Saturday"
weekday otherwise = "unknown"


-- guard
scoreCheck :: Int -> String
scoreCheck x
  | x == 100 = "Excellent!!"
  | x > 90 = "very good!"
  | x > 80 = "good."
  | x > 70 = "so so."
  | otherwise = "do your best ><"

-- 関数合成
addOne :: Int -> Int
addOne x = x + 1

addOneThenDouble :: Int -> Int
addOneThenDouble x = doubleMe (addOne x)

addOneThenDouble' :: Int -> Int
addOneThenDouble' = doubleMe . addOne

-- 型クラス
equalInt :: Int -> Int -> Bool
equalInt x y = x == y

equalEq :: (Eq a) => a -> a -> Bool
equalEq x y = x == y
