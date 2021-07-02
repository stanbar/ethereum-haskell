-- module Main where

-- import Lib
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe

data Transaction = Transaction { from :: String
  , to :: String
    , value :: Integer
} deriving Show


type State = Map String Integer

actualUpdate :: Maybe a -> payer -> State -> State
actualUpdate f payer state = Map.update f payer state

updateLedger :: State -> Transaction -> State
updateLedger state tx = actualUpdate f payer state
    where f currentValue = if currentValue >= amount then Just $ currentValue - amount else Nothing
          payer = from tx
          amount = value tx

sigma :: State -> [Transaction] -> State
sigma = foldl updateLedger


-- sigma state txs -> do  

main :: IO (State)
main = do
  let myState = Map.fromList [("stasbar", 5), ("gbaranski", 4)]
      transactions = [Transaction {from="stasbar", to="gbaranski", value=6}, Transaction {from="stasbar", to="gbaranski", value=4}]
  return $ sigma myState transactions
