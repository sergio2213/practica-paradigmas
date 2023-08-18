module Recursividad where

-- ::::::::::::
-- RECURSIVIDAD
-- ::::::::::::

-- Serie de Fibonacci
fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci numero
    | numero > 0 = fibonacci (numero - 1) + fibonacci (numero - 2)

-- TUPLAS
type Nombre = String
type Apellido = String
type Nota = Int
type Estudiante = (Nombre, Apellido, [Nota])

