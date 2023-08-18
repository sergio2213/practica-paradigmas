module Composicion where

hello :: String -> String
hello nombre = "hello, " ++ nombre

-- vamos a crear una función even . succ
-- componiendo las funciones even y succ
siguienteEsPar = even . succ

-- este siguiente expresión es equivalente a la anterior
siguienteEsPar' numero = even (succ numero)

-- pero la primera devuelve una función y la segunda, un Bool

