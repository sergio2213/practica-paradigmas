module Currificacion where
import OrdenSuperior

maximoA :: Integer -> (Integer -> Integer)
maximoA x = max x -- devuelve una función


-- :::::::::::::::
-- INMUTABILIDAD
-- :::::::::::::::

-- creamos una función que tenga como parámetro una Persona y retorne Persona
cumplirAnios :: Persona -> Persona
cumplirAnios persona = persona {
    edad = edad persona + 1
}