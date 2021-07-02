module Transaction (Transaction(..)) where

import Signature

data Transaction = Transaction
  { from :: String
  , to :: String
  , value :: Integer
  }
  deriving (Show)

