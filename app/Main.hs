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
  Map.adjust (+ amount) payee $ Map.adjust (subtract amount) payer state
  where
    payer = from tx
    payee = to tx
    amount = value tx

sigma :: State -> Transaction -> State
sigma state tx = do
  case payerBalance of
    Just currentValue ->
      if currentValue >= amount
        then updateLedger state tx
        else state
    Nothing -> state
  where
    payerBalance = Map.lookup payer state
    payer = from tx
    amount = value tx

stateTransition :: State -> [Transaction] -> State
stateTransition = foldl sigma

main :: IO ()
main = do
  let myState = Map.fromList [("stasbar", 5), ("gbaranski", 4)]
      transactions =
        [ Transaction {from = "stasbar", to = "gbaranski", value = 6},
          Transaction {from = "stasbar", to = "gbaranski", value = 4},
          Transaction {from = "stasbar", to = "gbaranski", value = 2},
          Transaction {from = "stasbar", to = "gbaranski", value = 1},
          Transaction {from = "gbaranski", to = "stasbar", value = 9}
        ]
  let finalState = stateTransition myState transactions
  print finalState
