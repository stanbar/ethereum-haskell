-- module Main where

-- import Lib
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe

main :: IO ()
main = do
  let myState = Map.fromList [("stasbar", withBalance 5), ("gbaranski", withBalance 4)]
      transactions =
        [ Transaction {from = "stasbar", to = "gbaranski", value = 6},
          Transaction {from = "stasbar", to = "gbaranski", value = 4},
          Transaction {from = "stasbar", to = "gbaranski", value = 2},
          Transaction {from = "stasbar", to = "gbaranski", value = 1},
          Transaction {from = "gbaranski", to = "stasbar", value = 9}
        ]
  let finalState = stateTransition myState transactions
  print finalState

data Transaction = Transaction
  { from :: String,
    to :: String,
    value :: Integer
  }
  deriving (Show)

data Account = Account
  { nonce :: Integer,
    balance :: Integer,
    storageRoot :: Integer,
    codeHash :: Integer
  }
  deriving (Show)

withBalance balance = Account {nonce = 0, balance = balance, storageRoot = 0, codeHash = 0}

type State = Map String Account

updateBalance :: (Integer -> Integer) -> Account -> Account
updateBalance adjuster acc = do
  Account
    { nonce = nonce acc,
      balance = adjuster $ balance acc,
      storageRoot = storageRoot acc,
      codeHash = codeHash acc
    }

updateLedger :: State -> Transaction -> State
updateLedger state tx = do
  Map.adjust (updateBalance (+ amount)) payee $ Map.adjust (updateBalance (subtract amount)) payer state
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
