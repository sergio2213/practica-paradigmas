module FuncionPorPartes where
import OrdenSuperior

-- ::::::::::::::::::
-- FUNCIÓN POR PARTES
-- ::::::::::::::::::

modulo :: Int -> Int
modulo x
    | x >= 0 = x
    | x < 0 = -x

esAdulto :: Persona -> Bool
esAdulto = (>= 18) . edad

-- no abusar de las guardas
-- reescribir la siguiente función con pattern matching
-- ivaPara actividad | actividad == "cultural" = 0.0
--                   | actividad == "alimentaria" = 10.5
--                   | otherwise = 21.0

ivaPara :: Fractional a => String -> a
ivaPara "cultural" = 0.0
ivaPara "alimentaria" = 10.5
ivaPara _ = 21.0

-- creamos función longitud
longitud :: [a] -> Int
longitud lista
    | null lista = 0
    | otherwise = 1 + longitud (tail lista)

-- pero puede quedar más declarativo
longitud' :: [a] -> Int
longitud' [] = 0
longitud' (_:xs) = 1 + longitud' (xs)


-- Realizar el siguiente ejemplo

-- Se quiere saber el precio del boleto a partir de la cantidad de kms que voy a recorrer. Se sabe que a
-- partir de 4 km, el cálculo del boleto es el cálculo máximo ($2 + $0.1 x cantidad de kms), mientras que
-- hasta los 4km, el cálculo es el 110% del cálculo máximo

precioBoleto :: (Fractional a, Ord a) => a -> a
precioBoleto kms
    | kms < 4 = (2.0 + 0.1 * kms) * 1.1
    | otherwise = 2.0 + 0.1 * kms

-- lo hacemos de otra forma
-- delegamos la operación 2.0 + 0.1 * kms a otra función que llamaremos precioMaximo
precioBoleto' :: Float -> Float
precioBoleto' kms
    | kms < 4 = precioMaximo kms * 1.1
    | otherwise = precioMaximo kms

precioMaximo :: Float -> Float
precioMaximo kms = 2.0 + 0.1 * kms