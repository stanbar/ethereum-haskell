module Block () where

import Transaction
import qualified Data.ByteString as Bytes

data Block = Block {
   parentHash :: Bytes.ByteString  -- H_i
   , beneficiary :: String -- H_c
   , stateRoot :: Bytes.ByteString -- H_r
   , transactionsRoot :: Bytes.ByteString -- H_t
   , number :: Bytes.ByteString -- H_i
   , timestamp :: Integer -- H_s
   , extraData :: Bytes.ByteString -- H_x
   , mixHash :: Bytes.ByteString -- H_m
   , nonce :: Integer -- H_n

   , transactions :: [Transaction] -- B_t
}

