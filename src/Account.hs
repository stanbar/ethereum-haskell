module Account (Account(..), updateBalance, withBalance) where

data Account = Account
  { nonce :: Integer,
    balance :: Integer,
    storageRoot :: Integer,
    codeHash :: Integer
  }
  deriving (Show)

withBalance balance = Account {nonce = 0, balance = balance, storageRoot = 0, codeHash = 0}

updateBalance :: (Integer -> Integer) -> Account -> Account
updateBalance adjuster acc = do
  Account
    { nonce = nonce acc,
      balance = adjuster $ balance acc,
      storageRoot = storageRoot acc,
      codeHash = codeHash acc
    }
