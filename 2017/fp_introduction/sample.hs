-- function
doubleMe :: Int -> Int
doubleMe x = x * 2

-- pattern match
dayOfTheWeek :: Int -> String
dayOfTheWeek 0 = "Sunday"
dayOfTheWeek 1 = "Monday"
dayOfTheWeek 2 = "Tuesday"
dayOfTheWeek 3 = "Wednesday"
dayOfTheWeek 4 = "Thursday"
dayOfTheWeek 5 = "Friday"
dayOfTheWeek 6 = "Saturday"
dayOfTheWeek otherwise = "unknown"


-- guard
scoreCheck :: Int -> String
scoreCheck x
  | x == 100 = "Excellent!!"
  | x > 90 = "very good!"
  | x > 80 = "good."
  | x > 70 = "so so."
  | otherwise = "do your best >_<"

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
