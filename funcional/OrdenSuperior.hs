module OrdenSuperior where

-- :::::::::::::::
-- ORDEN SUPERIOR
-- :::::::::::::::

-- Filter - ejemplos
-- obtener números pares de una lista de números
numeros = [3,4,5,9,6,7,8]
getPares :: [Integer] -> [Integer]
getPares = filter even

-- para los siguientes ejemplos modelaremos Persona e instanciamos tres personas y las metemos en una lista
data Persona = Persona {
    nombre :: String,
    apellido :: String,
    edad :: Int
} deriving (Show, Eq)

sergioPersona = Persona {
    nombre = "Sergio",
    apellido = "Ramos",
    edad = 31
}

silviaPersona= Persona {
    nombre = "Silvia",
    apellido = "Ramos",
    edad = 31
}

pepitoPersona = Persona {
    nombre = "Pepe",
    apellido = "Lopez",
    edad = 16
}

personas = [sergioPersona, silviaPersona, pepitoPersona]

-- crearemos un filtro que dada una lista de Persona no devuelva otra lista con aquellas que tengan 18 años o más
personasMayores :: [Persona] -> [Persona]
personasMayores = filter ((>= 18) . edad)

-- crearemos una función que me devuelva en una lista todos los nombres
todosLosNombres :: [Persona] -> [String]
todosLosNombres = map nombre
