-- module Main where

-- import Lib
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe

data Transaction = Transaction
  { from :: String,
    to :: String,
    value :: Integer
  }
  deriving (Show)

type State = Map String Integer

updateLedger :: State -> Transaction -> State
updateLedger state tx = do
  let state' = Map.update accountPayer payer state
  Map.update accountPayee payee state'
  where
    accountPayer currentValue = if currentValue >= amount then Just $ currentValue - amount else Nothing
    accountPayee currentValue = if currentValue >= amount then Just $ currentValue + amount else Nothing
    payer = from tx
    payee = to tx
    amount = value tx

sigma :: State -> [Transaction] -> State
sigma = foldl updateLedger

-- sigma state txs -> do

main :: IO ()
main = do
  let myState = Map.fromList [("stasbar", 5), ("gbaranski", 4)]
      transactions = [Transaction {from = "stasbar", to = "gbaranski", value = 6}, Transaction {from = "stasbar", to = "gbaranski", value = 4}]
  let finalState = sigma myState transactions
  print finalState
