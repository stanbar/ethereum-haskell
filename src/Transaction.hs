module Transaction (Transaction(..)) where

data Transaction = Transaction
  { from :: String,
    to :: String,
    value :: Integer
  }
  deriving (Show)

