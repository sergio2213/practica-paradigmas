module TypeClasses where

-- ::::::::::::
-- TYPECLASSES
-- ::::::::::::

-- los Typeclasses más populares en Haskell son: Num, Eq y Ord

-- Num
squares :: (Num a, Num b, Num c) => (a, b, c) -> (a, b, c)
squares (x, y, z) = (x * x, y * y, z * z)

