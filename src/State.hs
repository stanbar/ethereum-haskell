module State (State(..), updateLedger, sigma, stateTransition) where

import Account
import Transaction
import Data.Map (Map)
import qualified Data.Map as Map

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

