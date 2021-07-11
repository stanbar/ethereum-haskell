module Transaction (Transaction (..)) where

import qualified Data.ByteString as Bytes
import Signature

data Transaction = Transaction
  { nonce :: Integer
  , gasPrice :: Integer
  , gasLimit :: Integer
  , from :: String
  , to :: String
  , value :: Integer
  , sig :: Signature

  , body :: Bytes.ByteString  -- either init or data
  }
  deriving (Show)
