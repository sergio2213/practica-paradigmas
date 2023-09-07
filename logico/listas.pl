% LISTAS
% una lista es un conjunto de elementos en orden
% está compuesta de una lista y una cola
% los elementos no están obligados a ser del mismo tipo

% Ejemplo
% receta(Nombre, Ingrediente).
%     Ingrediente: [ingrediente(Nombre, Cantidad)] |
% ni idea por qué lo ponía así
% imagino que se verá más a fondo la sintáxis más adelante

% receta(caramelo, [ingrediente(agua, 100), ingrediente(azucar, 100)]).
% acá usamos una lista de ingredientes
% ingrediente es un functor

% Predicados de listas
% ::: member :::
% member(Elemento, Lista) -> relaciona un elemento con una lista si ese elemento
% pertenece a dicha lista

% ejemplo de uso
% member(pesto, [agua, tierra, aire, fuego]).
% False


% ::: length :::
% length(Lista, Tamanio) -> relaciona un elemento con un tamaño, si dicho tamaño
% representa la cantidad de elementos de esa lista

% ejemplo de uso
% length([piedra, papel, tijera], 3).
% True

% length([piedra, papel, tijera], Tamanio).
% Tamanio = 3


% ::: sumlist :::
% sumlist(Lista, Total) -> relaciona una lista con un número, si dicho número
% representa a la sumatoria de toda la lista

% ejemplo de uso
% sumList([1,2,3], 3).
% True

% sumlist([1,2,3], Total).
% Total = 6


% Ejemplos para mejorar la comprensión
% armar el predicado rapida/1
% una receta es rapida si tiene menos de 4 ingredientes

receta(caramelo, [ingrediente(agua, 100), ingrediente(azucar, 100)]).

rapida(Receta) :-
    receta(Receta, Ingredientes),
    length(Ingredientes, Total),
    Total < 4.

% armar el predicado postre/1
% una receta es postre si tiene más de 250 de azúcar

receta(flan, [ingrediente(vainilla, 50), ingrediente(azucar, 300)]).

postre(Receta) :-
    receta(Receta, Ingredientes),
    member(ingrediente(azucar, Cantidad), Ingredientes),
    Cantidad > 250.


% FINDALL
% es un predicado de órden superior que reciben tres parámetros
% findall(Selector, Consulta, Lista)
% Selector: es una variable (¿qué porción de la respuesta yo quiero?)
% Consulta: es una consulta existencial
% Lista: lista donde se va a ligar el resultado de la consulta

% Ejemplo de uso
% receta(Nombre, Ingredientes).
% retorna todas las recetas con sus respectivos ingredientes
% pero si quiero solo una lista con los nombres de las recetas
% puede hacer la siguiente consulta

% findall(Nombre, receta(Nombre, Ingredientes), Recetas).
% Recetas = [caramelo, flan]

% findall(Nombre, (receta(Nombre, _), rapida(Nombre)), Recetas).
% Recetas = [caramelo, flan]

% findall(dulce(Nombre), postre(Nombre), Dulces). -> "envolvelo en dulce"
% Dulces = [dulce(flan)]

% Usos
% lo usaremos para agrupar respuestas a consultas



% Otro ejemplo
% armar el predicado cantidadDePostres(Cantidad)
% donde se cumpla para el número de recetas de postre en la base

cantidadDePostres(Cantidad) :-
    findall(1, postre(Receta), Postres),
    sumlist(Postres, Cantidad).
% el findall devuelve una lista con unos, uno por cada postre
% luego sumamos y evaluamos si es igual a la cantidad ingresada
% por parámetro



% :::::: PRÁCTICA ::::::

% receta(Nombre, Ingrediente).
% ingrediente(Ingrediente).
calorias(Ingrediente, Calorias).

% Práctica
% Extender la base de conocimiento con los siguientes predicados:
% 1. trivial/1: Se cumple para las recetas con un único ingrediente.
trivial(Receta) :-
    receta(Receta, Ingredientes),
    length(Ingredientes, Cantidad),
    Cantidad = 1.

trivial(Receta) :-
    receta(Receta, [_]).
% esta es la forma más corta y más expresiva

% 2. elPeor /2: Relaciona una receta con su ingrediente más calórico.
elPeor([Peor], Peor).
elPeor([Ingrediente | Otros], Ingrediente) :-
    elPeor(Otros, OtroIngrediente),
    calorias(OtroIngrediente, CaloriasOtroIngrediente),
    calorias(Ingrediente, CaloriasIngrediente),
    CaloriasIngrediente >= CaloriasOtroIngrediente.
elPeor([Ingrediente | Otros], OtroIngrediente) :-
    calorias(OtroIngrediente, CaloriasOtroIngrediente),
    calorias(Ingrediente, CaloriasIngrediente),
    CaloriasOtroIngrediente > CaloriasIngrediente.
% lo resolvemos por recursividad

elPeor(Ingredientes, Peor) :-
    member(Peor, Ingredientes),
    calorias(Peor, CaloriasPeorIngrediente),
    forall(
        calorias(Ingrediente, Calorias),
        (calorias(Ingrediente, CaloriasIngrediente), CaloriasPeorIngrediente >= CaloriasIngrediente)
    ).
% lo podemos resolver de una forma más sencilla

% 3. caloriasTotales/2: Relaciona una receta y su total de calorías.
caloriasTotales(Receta, TotalCalorias) :-
    receta(Receta, Ingredientes),
    findall(Calorias, (member(Ingrediente, Ingredientes), calorias(Ingrediente, Calorias)), Resultado),
    sumlist(Resultado, TotalCalorias).

% 4. versionLight/2: Relaciona una receta con sus ingredientes, sin el peor.
versionLight(Receta, IngredientesSinElPeor) :-
    receta(Receta, Ingredientes),
    elPeor(Ingredientes, Peor),
    findall(Ingrediente, (member(Ingrediente, Ingredientes), Ingrediente \= Peor), IngredientesSinElPeor).

% 5. guasada/1: Se cumple para una receta con algún ingrediente de más de
% 1000Kcal.
guasada(Receta) :-
    receta(Receta, Ingredientes),
    member(IngredienteEngordador, Ingredientes),
    calorias(IngredienteEngordador, Calorias),
    Calorias > 1000.
