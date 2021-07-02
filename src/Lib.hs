module Lib
    ( someFunc
    ) where

factorial 0 = 1
factorial n = n * factorial (n - 1)

secsToWeeks secs = let perMinute = 60
                       perHour = 20 * perMinute
                       perDay    = 24 * perHour
                       perWeek   =  7 * perDay
                   in  secs / perWeek

classify age = case age of 0 -> "newborn"
                           1 -> "infant"
                           2 -> "toddler"
                           3 -> "senioior citiizen"


someFunc :: IO ()
someFunc = do putStrLn "What is 5! ?"
              x <- readLn
              if x == factorial 5
              then putStrLn "You're right!"
              else putStrLn "You're wrong!"

