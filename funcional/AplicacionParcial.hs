module AplicacionParcial where

-- ::::::::::::::::::
-- APLICACIÓN PARCIAL
-- ::::::::::::::::::

-- se trata de usar una función con menos parámetros de los que ésta requiere
-- creamos una función que, dados tres parámetros, me devuelva el mayor
dameMayor :: Int -> Int -> Int -> Int
dameMayor x y z = max (max x y) z

-- podemos aplicar Aplicación Parcial de esta forma
-- (dameMayor 10)
-- ahora tenemos una función que espera dos parámetros

-- la Aplicación Parcial no está limitada solo al primer parámetro
-- por ejemplo, podemos aplicar parcialmente el segundo parámetro de una función
-- para que exista Aplicación Parcial, la función en cuestión deberá tener por lo menos dos parámetros

-- crearemos una función que nos dice si una palabra tiene las vocales a, e, i.
tieneAEI palabra = any (elem "AEIaei") palabra
-- tenemos que comprobara si alguna letra de la palabra está incluída en el String "AEIaei"
-- pero ésto no nos va a funcionar, porque la palabra es primer parámetro de la función elem
-- elem "unapalabra" "AEIaei" -> ésto es incorrecto

-- ¿Cómo lo solucionamos?
-- podemos rearmar esta función de tres formas:
-- 1. Con función lambda
tieneAEI' :: String -> Bool
tieneAEI' = any (\letra -> elem letra "AEIaei")
-- 2. Con notación infija
tieneAEI'' :: String -> Bool
tieneAEI'' = any (`elem` "AEIaei")
-- 3. Con función flip
tieneAEI''' :: String -> Bool
tieneAEI''' palabra = any (flip elem "AEIaei") palabra

-- otro ejemplo
between :: Int -> Int -> Int -> Bool
between menor mayor numero = menor < numero && mayor > numero

-- a partir de esta última función creamos otra usando aplicación parcial
betweenOneAndTen :: Int -> Bool
betweenOneAndTen = between 1 10


-- ::::::::::::::
-- EJEMPLO SPOTIFY
-- ::::::::::::::

-- Supongamos que trabajamos para Spotify. Recién estamos empezando, y tenemos que modelar las
-- canciones y los usuarios en Haskell. Elegimos modelarlos con data, donde cada canción tiene
-- un nombre, la cantidad de likes y dislikes; y cada usuario tiene un nombre de usuario y un
-- número que representa hace cuántos años usa Spotify:


-- MODELADO
data Cancion = Cancion {
    nombre :: String,
    likes :: Float,
    dislikes :: Float
} deriving (Show, Eq)

data Usuario = Usuario {
    nombreUsuario :: String,
    antiguedad :: Float
} deriving (Show, Eq)

-- función que dado un usuario y una canción nos dice si dicha canción es recomendable para el usuario
tasaDeRecomendabilidad :: Usuario -> Cancion -> Float
tasaDeRecomendabilidad usuario cancion = 
    likes cancion / (dislikes cancion) * (antiguedad usuario) + (likes cancion) * pi / 29

-- podemos crear una función que nos dice qué tan recomendable es una canción para un usuario
esTasaRecomendable :: Float-> Bool
esTasaRecomendable tasa = tasa > 1000

-- finalmente podemos crear una función que decida si poner o no una canción en el Inicio del usuario
vaEnPantallaDeInicioDe :: Usuario -> Cancion -> Bool
vaEnPantallaDeInicioDe usuario = (esTasaRecomendable . (tasaDeRecomendabilidad usuario))