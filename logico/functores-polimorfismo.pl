% FUNCTORES Y POLIMORFISMO
% vende(Titulo, Auto, Genero, Editorial, Precio).

% FUNCTORES
% sería más o menos como tener un predicado asociado a otro, o que se puede usar un predicado
% dentro de otro
% Ejemplo
vende(Articulo, Precio).
Articulo = libro(Nombre, Autor, Genero, Editorial) | cd(Titulo, Autor, Genero, CantDiscos, CantTemas).
% libro(Nombre, Autor, Genero, Editorial).
% cd(Titulo, Autor, Genero, CantDiscos, CantTemas).

% nos podemos permitir hacer lo siguiente
vende(libro(harryPotter1, jkRowling, fantasia, salamandra), 1500).
vende(cd(saturate, breakingBenjamin, rock, 10, 13), 2000).
% libro/4 y cd/4 son functores

% los functores solo pueden estar como parámetros de los predicados

% y si quiero un libro en específico que esté a la venta y cuyo autor sea Stephen King
% vende(libro(Nombre, stephenKing, _, _), _).

% no se puede hacer la consulta, porque libro es un functor
% libro(Nombre, stephenKing, _, _)
% para eso debemos usar el predicado vende/2

% vamos a definir un predicado tematico/1 que se cumple para un autor
% si todo lo que se vende es de él

tematico(Autor) :-
    forall(vende(Articulo, _), autor(Articulo, Auto)).

% pero autor/2 no existe como predicado, entonces lo creamos
autor(libro(_, Autor, _, _), Autor) :-
    vende(libro(_, Autor, _, _), _).
autor(cd(_, Autor, _, _, _), Autor) :-
    vende(cd(_, Autor, _, _, _), _).
% "el autor de este artículo es éste siempre y cuando esté a la venta"
% estamos aplicando polimorfismo en autor/2 (es un predicado polimorfico)
% Articulo puede tener forma de libro o cd, pero no nos interesa

% 32:30
