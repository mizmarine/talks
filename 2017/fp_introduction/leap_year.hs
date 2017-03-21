isLeapYear :: Int -> Bool
isLeapYear x
  | mod x 400 == 0 = True
  | mod x 100 == 0 = False
  | mod x 4 == 0 = True
  | otherwise = False
