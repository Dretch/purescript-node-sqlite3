# purescript-node-sqlite3

Really basic wrapper for [node-sqlite3](https://github.com/mapbox/node-sqlite3)

Of course, this is nowhere near done, so please suggest improvements and additions!

## Installation

`bower i -S purescript-node-sqlite3 && npm i -S sqlite3`

## Usage

```haskell
launchAff do
  conn <- newDB "./data"

  exists <- (\rows -> 1 == length rows) <$> queryDB conn "SELECT 1 from foods where name = ?" ["gulerodskage-med-flødest"]
  log $ "do we have this?: " <> (show exists)

  closeDB conn
```
