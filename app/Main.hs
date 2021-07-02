module Main where

import Account as Account
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe
import Transaction

main = do
  let myState = Map.fromList [("stasbar", Account.withBalance 5), ("gbaranski", Account.withBalance 4)]
      transactions =
        [ Transaction {from = "stasbar", to = "gbaranski", value = 6},
          Transaction {from = "stasbar", to = "gbaranski", value = 4},
          Transaction {from = "stasbar", to = "gbaranski", value = 2},
          Transaction {from = "stasbar", to = "gbaranski", value = 1},
          Transaction {from = "gbaranski", to = "stasbar", value = 9}
        ]
  let finalState = stateTransition myState transactions
  print finalState

type State = Map String Account

updateLedger :: State -> Transaction -> State
updateLedger state tx = do
  Map.adjust (Account.updateBalance (+ amount)) payee $
    Map.adjust (Account.updateBalance (subtract amount)) payer state
  where
    payer = from tx
    payee = to tx
    amount = value tx

sigma :: State -> Transaction -> State
sigma state tx = do
  case Map.lookup payer state of
    Just payerAccount ->
      if amount <= balance payerAccount
        then updateLedger state tx
        else state
    Nothing -> state
  where
    payer = from tx
    amount = value tx

stateTransition :: State -> [Transaction] -> State
stateTransition = foldl sigma
