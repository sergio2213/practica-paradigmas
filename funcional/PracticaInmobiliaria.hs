module PracticaInmobiliaria where

type Barrio = String
type Mail = String
type Requisito = Depto -> Bool
type Busqueda = [Requisito]

data Depto = Depto {
 ambientes :: Int,
 superficie :: Int,
 precio :: Int,
 barrio :: Barrio
} deriving (Show, Eq)

data Persona = Persona {
   mail :: Mail,
   busquedas :: [Busqueda]
}
ordenarSegun :: (a -> a -> Bool) -> [a] -> [a]
ordenarSegun _ [] = []
ordenarSegun criterio (x:xs) =
 (ordenarSegun criterio . filter (not . criterio x)) xs ++
 [x] ++
 (ordenarSegun criterio . filter (criterio x)) xs

between :: (Ord a) => a -> a -> a -> Bool
between cotaInferior cotaSuperior valor =
 valor <= cotaSuperior && valor >= cotaInferior

deptosDeEjemplo = [
 Depto 3 80 7500 "Palermo",
 Depto 1 45 3500 "Villa Urquiza",
 Depto 2 50 5000 "Palermo",
 Depto 1 45 5500 "Recoleta"]


-- Se pide desarrollar las siguientes funciones y consultas de modo que se aprovechen tanto como
-- sea posible los conceptos de orden superior, aplicación parcial y composición.

-- 1.
-- a. Definir las funciones mayor y menor que reciban una función y dos valores, y retorna true si
-- el resultado de evaluar esa función sobre el primer valor es mayor o menor que el resultado de
-- evaluarlo sobre el segundo valor respectivamente.

mayor :: (Ord b) => (a -> b) -> (a -> a -> Bool)
mayor f x y = f x >= f y

menor :: (Ord b) => (a -> b) -> (a -> a -> Bool)
menor f x y = f x < f y

-- b. Mostrar un ejemplo de cómo se usaría una de estas funciones para ordenar una lista de strings
-- en base a su longitud usando ordenarSegun.
ordenarListaPorLongitud :: [String] -> [String]
ordenarListaPorLongitud = (ordenarSegun . menor) length
-- conviene hacer un esquemita para entenderlo mejor

-- 2.
-- a. ubicadoEn que dada una lista de barrios que le interesan al usuario, retorne verdadero si el
-- departamento se encuentra en alguno de los barrios de la lista.
ubicadoEn :: [Barrio] -> Depto -> Bool
ubicadoEn barrios depto = any (== barrio depto) barrios

ubicadoEn' :: [Barrio] -> Depto -> Bool
ubicadoEn' barrios depto = elem (barrio depto) barrios

ubicadoEn'' :: [Barrio] -> (Depto -> Bool) -- es un requisito
ubicadoEn'' barrios = (`elem` barrios) . barrio

-- probar si los tres funcan de la misma manera
barrios = ["Villa Lugano", "Mataderos", "Palermo", "Parque Patricios"]
deptoEjemplo = Depto 3 80 7500 "Villa Soldati"

-- b. cumpleRango que a partir de una función y dos números, indique si el valor retornado por la
-- función al ser aplicada con el departamento se encuentra entre los dos valores indicados.
cumpleRango :: Ord a => (Depto -> a) -> a -> a -> (Depto -> Bool)
cumpleRango f cotaInferior cotaSuperior = between cotaInferior cotaSuperior . f

cumpleRango' :: Ord a => (Depto -> a) -> a -> a -> (Depto -> Bool)
cumpleRango' f cotaInferior cotaSuperior depto = between cotaInferior cotaSuperior (f depto)

-- 3
-- a. Definir la función cumpleBusqueda que se cumple si todos los requisitos de una búsqueda se
-- verifican para un departamento dado.
cumpleBusqueda :: Busqueda -> Depto -> Bool
cumpleBusqueda busqueda depto = all (\requisito -> requisito depto) busqueda

cumpleBusqueda' :: Depto -> Busqueda -> Bool
cumpleBusqueda' depto = all (\requisito -> requisito depto)

-- b. Definir la función buscar que a partir de una búsqueda, un criterio de ordenamiento y una
-- lista de departamentos retorne todos aquellos que cumplen con la búsqueda ordenados en base
-- al criterio recibido.
buscar :: Busqueda -> (Depto -> Depto -> Bool) -> [Depto] -> [Depto]
buscar busqueda criterio = ordenarSegun criterio . filter (cumpleBusqueda busqueda)

buscar' :: Busqueda -> (Depto -> Depto -> Bool) -> [Depto] -> [Depto]
buscar' busqueda criterio = ordenarSegun criterio . filter (flip cumpleBusqueda' busqueda)

-- c. Mostrar un ejemplo de uso de buscar para obtener los departamentos de ejemplo, ordenado por
-- mayor superficie, que cumplan con:
-- Encontrarse en Recoleta o Palermo
-- Ser de 1 o 2 ambientes
-- Alquilarse a menos de $6000 por mes
busqueda = [ubicadoEn ["Recoleta", "Palermo"], cumpleRango ambientes 1 2,  cumpleRango precio 0 6000]
busquedaEjemplo = buscar busqueda (mayor superficie)

-- 4. Definir la función mailsDePersonasInteresadas que a partir de un departamento y una lista de
-- personas retorne los mails de las personas que tienen alguna búsqueda que se cumpla para el
-- departamento dado.
mailsDePersonasInteresadas :: Depto -> [Persona] -> [Mail]
mailsDePersonasInteresadas depto = map mail . filter (any (\busqueda -> cumpleBusqueda busqueda depto) . busquedas)
