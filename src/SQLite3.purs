module SQLite3 where

import Prelude
import Control.Monad.Aff (Aff, makeAff)
import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (runFn4, runFn2, Fn4, Fn2)

type FilePath = String
type Query = String
type Param = String

foreign import data DBRow :: *
foreign import data DBConnection :: *
foreign import data DBEffects :: !

foreign import _newDB :: forall e.
  Fn2
    FilePath
    (DBConnection -> Eff (db :: DBEffects | e) Unit)
  (Eff (db :: DBEffects | e) Unit)
foreign import _closeDB :: forall e.
  Fn2
    DBConnection
    (Unit -> Eff (db :: DBEffects | e) Unit)
    (Eff (db :: DBEffects | e) Unit)
foreign import _queryDB :: forall e.
  Fn4
    DBConnection
    Query
    (Array Param)
    (Array DBRow -> Eff (db :: DBEffects | e) Unit)
  (Eff (db :: DBEffects | e) Unit)

newDB :: forall e. FilePath -> Aff (db :: DBEffects | e) DBConnection
newDB path = makeAff (\e s -> runFn2 _newDB path s)
closeDB :: forall e. DBConnection -> Aff (db :: DBEffects | e) Unit
closeDB conn = makeAff (\e s -> runFn2 _closeDB conn s)
queryDB :: forall e. DBConnection -> Query -> Array Param -> Aff (db :: DBEffects | e) (Array DBRow)
queryDB conn query params = makeAff (\e s -> runFn4 _queryDB conn query params s)
