module Basico where

-- doble de un número
doble numero = numero + numero

-- creamos un función que nos dice si un día de la semana es fin de semana
esFinde dia = dia == "Sábado" || dia == "Domingo"
-- devuelve booleano

-- lo podemos hacer de otra forma
esFinde' dia
    | dia == "Sábado" || dia == "Domingo" = "Es finde"
    | otherwise = "No es finde"
-- devuelve un String

-- factorial de un número
factorial numero
    | numero == 0 = 1
    | numero == 1 = 1
    | otherwise = numero * factorial(numero - 1)

-- de una forma más corta
factorial' 0 = 1
factorial' numero = numero * factorial(numero - 1)

-- Listas
-- vamos a crear algunas listas
algunasMateriasAprobadas = [
    "Arquitectura de Computadores",
    "Algoritmos y Estructuras de Datos",
    "Fisica I"]

lenguajesProgramacion = ["Java", "JavaScript", "Swift"]

lista1 = [(2,5),(5,3),(3,3)]
lista2 = [(2,5)]

-- podemos crear una lista con un solo elemento de esta forma
listaConUnElemento = ["Sergio"]

-- para obtener la cabeza usaremos la función head
-- para obtener la cola usaremos la función tail

-- puedo crear una lista de esta forma
nuevaLista = (23:25:[1,2,3])

-- podemos crear un data, por ejemplo: Alumno
data Alumno = Alumno String String deriving (Show, Eq)
-- para acceder a los atributos, hacemos lo siguiente
getNombre (Alumno nombre _) = nombre
getApellido (Alumno _ apellido) = apellido
-- crearemos un Alumno
sergio = Alumno "Sergio" "Ramos"
silvia = Alumno "Silvia" "Ramos"

-- o podemos crear un data usando el azúcar sintáctico
data Empleado = Empleado {
    nombre :: String,
    apellido :: String,
    edad :: Int
} deriving (Show, Eq)
-- crearemos un empleade
alvaro = Empleado {
    nombre = "Alvaro",
    apellido = "Canaviri",
    edad = 33
}


