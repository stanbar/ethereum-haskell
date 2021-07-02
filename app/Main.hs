module Main where

import Account
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe
import Transaction
import State (stateTransition)

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

