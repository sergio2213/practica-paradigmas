module PracticaGimnasio where

-- Se desea desarrollar un sistema para un popular gimnasio que permita calcular el efecto
-- de las rutinas de ejercicios que realizan sus socios.

-- De cada gimnasta nos interesa saber su peso y su coeficiente de tonificación.

-- Los profesionales del gimnasio preparan rutinas de ejercicios pensadas para las
-- necesidades de cada gimnasta. Una rutina es una lista de ejercicios que el
-- gimnasta realiza durante unos minutos para quemar calorías y tonificar sus músculos.

-- 1. Modelar a los Gimnastas y las operaciones necesarias para hacerlos ganar tonificación
-- y quemar calorías considerando que por cada 500 calorías quemadas se baja 1 kg de peso.
data Gimnasta = Gimnasta {
    peso :: Int,
    tonificacion :: Int
} deriving (Show, Eq)

tonificar :: Int -> Gimnasta -> Gimnasta
tonificar n gimnasta = gimnasta {
    tonificacion = tonificacion gimnasta + n
}

quemarCalorias :: Int -> Gimnasta -> Gimnasta
quemarCalorias calorias gimnasta = gimnasta {
    peso = peso gimnasta - (calorias `div` 500)
}

type Ejercicio = Int -> Gimnasta -> Gimnasta

-- 2. Modelar los siguientes ejercicios del gimnasio:
-- a. La cinta es una de las máquinas más populares entre los socios que quieren perder
-- peso. Los gimnastas simplemente corren sobre la cinta y queman calorías en función
-- de la velocidad promedio alcanzada (quemando 10 calorías por la velocidad promedio por minuto).
cinta :: Int -> Int -> Gimnasta -> Gimnasta
cinta velocidad duracion = quemarCalorias (10 * velocidad * duracion)

-- La cinta puede utilizarse para realizar dos ejercicios diferentes:

-- i. La caminata es un ejercicio en cinta con velocidad constante de 5 km/h.
caminata :: Int -> Gimnasta -> Gimnasta
caminata = cinta 5

-- ii. El pique arranca en 20 km/h y cada minuto incrementa la velocidad en 1 km/h, con
-- lo cual la velocidad promedio depende de los minutos de entrenamiento.
pique :: Int -> Gimnasta -> Gimnasta
pique duracion = cinta (duracion `div` 2 + 20) duracion -- en este miré un poco la solución, no entendí del todo esa ec.

-- b. Las pesas son el equipo preferido de los que no quieren perder peso, sino ganar
-- musculatura. Una sesión de levantamiento de pesas de más de 10 minutos hace que el
-- gimnasta gane una tonificación equivalente a los kilos levantados. Por otro lado, una
-- sesión de menos de 10 minutos es demasiado corta, y no causa ningún efecto en el gimnasta.
pesas :: Int -> Int -> Gimnasta -> Gimnasta
pesas duracion kilos
    | duracion > 10 = tonificar kilos
    | otherwise = id -- función identidad

-- c. La colina es un ejercicio que consiste en ascender y descender sobre una superficie
-- inclinada y quema 2 calorías por minuto multiplicado por la inclinación con la que se
-- haya montado la superficie.
colina :: Int -> Int -> Gimnasta -> Gimnasta
colina duracion inclinacion = quemarCalorias (2 * duracion * inclinacion)

-- Los gimnastas más experimentados suelen preferir otra versión de este ejercicio: la
-- montaña, que consiste en 2 colinas sucesivas (asignando a cada una la mitad del tiempo
-- total), donde la segunda colina se configura con una inclinación de 5 grados más que
-- la inclinación de la primera. Además de la pérdida de peso por las calorías quemadas
-- en las colinas, la montaña incrementa en 3 unidades la tonificación del gimnasta.
montania :: Int -> Int -> Gimnasta -> Gimnasta
montania inclinacion duracion = tonificar 3 . colina (duracion `div` 2) (inclinacion + 5) . colina (duracion `div` 2) inclinacion

-- 3. Dado un gimnasta y una Rutina de Ejercicios, representada con la siguiente estructura:
data Rutina = Rutina {
    nombre :: String,
    duracionTotal :: Int,
    ejercicios :: [Ejercicio]
}

-- Implementar una función realizarRutina, que dada una rutina y un gimnasta retorna el
-- gimnasta resultante de realizar todos los ejercicios de la rutina, repartiendo el tiempo
-- total de la rutina en partes iguales. Mostrar un ejemplo de uso con una rutina que incluya
-- todos los ejercicios del punto anterior.
realizarRutina :: Rutina -> Gimnasta -> Gimnasta
realizarRutina rutina gimnastaInicial = foldl (\gimnasta ejercicio -> ejercicio (tiempoEjercicio rutina) gimnasta) gimnastaInicial (ejercicios rutina)

tiempoEjercicio :: Rutina -> Int
tiempoEjercicio rutina = (div (duracionTotal rutina) . length . ejercicios) rutina

-- 4. Definir las operaciones necesarias para hacer las siguientes consultas a partir de una lista de rutinas:
-- a. ¿Qué cantidad de ejercicios tiene la rutina con más ejercicios?
-- b. ¿Cuáles son los nombres de las rutinas que hacen que un gimnasta dado gane tonificación?
-- c. ¿Hay alguna rutina peligrosa para cierto gimnasta? Decimos que una rutina es peligrosa
-- para alguien si lo hace perder más de la mitad de su peso.