module ExpresionesLambda where
import OrdenSuperior

-- crearemos algunas funciones lambda

-- doble
dobleLambda :: Num a => a -> a
dobleLambda = \numero -> numero * 2

-- la función lambda puede recibir más de un parámetro
cuentaLocaLambda :: Num a => a -> a -> a -> a
cuentaLocaLambda = (\x y z -> 2 * x + y + z)

-- también podemos componer con otras funciones
esMayorLambda :: Persona -> Bool
esMayorLambda = (\edad -> edad >= 18) . edad

-- dentro de una función lambda se puede ignorar parámetros usando _ (guión bajo)
-- función que dada una tupla (String, String, Int) solo nos devuelve el tercer valor
getEdadLambda :: (String, String, Integer) -> Integer
getEdadLambda = (\(_, _, edad) -> edad)
alvaroTupla = ("Alvaro", "Canaviri", 35)

-- podemos usar expresiones lambda en vez de usar Aplicación Parcial
-- por ejemplo
dobleLista :: [Int] -> [Int]
dobleLista = map (* 2)

dobleListaLambda :: [Int] -> [Int]
dobleListaLambda = map (\n -> n + n)