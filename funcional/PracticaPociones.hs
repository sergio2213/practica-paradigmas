module PracticaPociones where

data Persona = Persona {
  nombrePersona :: String,
  suerte :: Int,
  inteligencia :: Int,
  fuerza :: Int
} deriving (Show, Eq)

data Pocion = Pocion {
  nombrePocion :: String,
  ingredientes :: [Ingrediente]
}

type Efecto = Persona -> Persona

data Ingrediente = Ingrediente {
  nombreIngrediente :: String,
  efectos :: [Efecto]
}

nombresDeIngredientesProhibidos = [
 "sangre de unicornio",
 "veneno de basilisco",
 "patas de cabra",
 "efedrina"]

maximoSegun :: Ord b => (a -> b) -> [a] -> a
maximoSegun _ [ x ] = x
maximoSegun  f ( x : y : xs)
  | f x > f y = maximoSegun f (x:xs)
  | otherwise = maximoSegun f (y:xs)


-- Se pide resolver los siguientes puntos utilizando los conceptos aprendidos del paradigma
-- funcional: composición, aplicación parcial y orden superior.

-- 1. Dada una persona definir las siguientes funciones para cuantificar sus niveles de suerte,
-- inteligencia y fuerza sin repetir código:
-- a. sumaDeNiveles que suma todos sus niveles.
sumaDeNiveles :: Persona -> Int
sumaDeNiveles persona = suerte persona + fuerza persona + inteligencia persona

sumaDeNiveles' :: Persona -> Int
sumaDeNiveles' = sum . niveles

-- b. diferenciaDeNiveles es la diferencia entre el nivel más alto y más bajo.
diferenciaDeNiveles :: Persona -> Int
diferenciaDeNiveles persona = nivelMasAlto persona - nivelMasBajo persona

nivelMasAlto :: Persona -> Int
nivelMasAlto persona = suerte persona `max` inteligencia persona `max` fuerza persona

nivelMasAlto' :: Persona -> Int
nivelMasAlto' = maximum . niveles

nivelMasBajo :: Persona -> Int
nivelMasBajo persona = suerte persona `min` inteligencia persona `min` fuerza persona

nivelMasBajo' :: Persona -> Int
nivelMasBajo' = minimum . niveles

-- por si las moscas
niveles :: Persona -> [Int]
niveles persona = [suerte persona, inteligencia persona, fuerza persona]

nivelMasAlto'' :: Persona -> Int
nivelMasAlto'' persona = maximum (niveles persona)

nivelMasBajo'' :: Persona -> Int
nivelMasBajo'' persona = minimum (niveles persona)
-- por si las moscas

-- c. nivelesMayoresA n, que indica la cantidad de niveles de la persona que están por
-- encima del valor dado.
nivelesMayoresA :: Int -> Persona -> Int
nivelesMayoresA valor = length . filter (> valor) . niveles

-- 2. Definir la función efectosDePocion que dada una poción devuelve una lista con
-- los efectos de todos sus ingredientes.
efectosDePocion :: Pocion -> [Efecto]
efectosDePocion = concat . map efectos . ingredientes

-- 3. Dada una lista de pociones, consultar:
-- a. Los nombres de las pociones hardcore, que son las que tienen al menos 4 efectos.
pocionesHardcore :: [Pocion] -> [String]
pocionesHardcore = map nombrePocion . filter ((> 3) . length . efectosDePocion)

-- b. La cantidad de pociones prohibidas, que son aquellas que tienen algún ingrediente
-- cuyo nombre figura en la lista de ingredientes prohibidos.
cantidadDePocionesProhibidas :: [Pocion] -> Int
cantidadDePocionesProhibidas = length . filter esProhibida

esProhibida :: Pocion -> Bool
esProhibida = any (\ingrediente -> nombreIngrediente ingrediente `elem` nombresDeIngredientesProhibidos) . ingredientes

-- c. Si son todas dulces, lo cual ocurre cuando todas las pociones de la lista tienen
-- algún ingrediente llamado “azúcar”.
esDulce :: Pocion -> Bool
esDulce = elem "Azucar" . map nombreIngrediente . ingredientes

todasDulces :: [Pocion] -> Bool
todasDulces = all esDulce

-- 4. Definir la función tomarPocion que recibe una poción y una persona, y devuelve
-- como quedaría la persona después de tomar la poción. Cuando una persona toma una
-- poción, se aplican todos los efectos de esta última, en orden.
tomarPocion :: Pocion -> Persona -> Persona
tomarPocion pocion personaInicial = foldl (\persona efecto -> efecto persona) personaInicial (efectosDePocion pocion)

-- 5. Definir la función esAntidotoDe que recibe dos pociones y una persona, y dice si
-- tomar la segunda poción revierte los cambios que se producen en la persona al tomar
-- la primera.
esAntidotoDe :: Pocion -> Pocion -> Persona -> Bool
esAntidotoDe pocion antidoto persona = ((== persona) . tomarPocion antidoto . tomarPocion pocion) persona

-- 6. Definir la función personaMasAfectada que recibe una poción, una función
-- cuantificadora (es decir, una función que dada una persona retorna un número) y una
-- lista de personas, y devuelve a la persona de la lista que hace máxima el valor del
-- cuantificador. Mostrar un ejemplo de uso utilizando los cuantificadores definidos
-- en el punto 1.
personaMasAfectada :: Pocion -> (Persona -> Int) -> [Persona] -> Persona
personaMasAfectada pocion f = maximoSegun f . map (tomarPocion pocion)

personaMasAfectada' :: Pocion -> (Persona -> Int) -> [Persona] -> Persona
personaMasAfectada' pocion f = maximoSegun (f . tomarPocion pocion) -- solución vista en el video de la clase
