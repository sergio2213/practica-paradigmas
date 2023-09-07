% FUNCTORES Y POLIMORFISMO
% supongamos que tenemos el siguiente predicado
% vende(Titulo, Autor, Genero, Editorial, Precio).

% FUNCTORES
% sería más o menos como tener un predicado asociado a otro, o que se puede usar un
% predicado dentro de otro
% Ejemplo
vende(Articulo, Precio).
Articulo = libro(Nombre, Autor, Genero, Editorial)
    | cd(Titulo, Autor, Genero, CantDiscos, CantTemas).
% libro(Nombre, Autor, Genero, Editorial).
% cd(Titulo, Autor, Genero, CantDiscos, CantTemas).

% nos podemos permitir hacer lo siguiente
vende(libro(harryPotter1, jkRowling, fantasia, salamandra), 1500).
vende(cd(saturate, breakingBenjamin, rock, 10, 13), 2000).
% libro/4 y cd/5 son functores

% los functores solo pueden estar como parámetros de los predicados

% y si quiero un libro en específico que esté a la venta y cuyo autor sea Stephen King
% vende(libro(Nombre, stephenKing, _, _), _).

% no se puede hacer la consulta, porque libro es un functor
% libro(Nombre, stephenKing, _, _)
% para eso debemos usar el predicado vende/2

% vamos a definir un predicado tematico/1 que se cumple para un autor
% si todo lo que se vende es de él

tematico(Autor) :-
    forall(vende(Articulo, _), autor(Articulo, Autor)).

% pero autor/2 no existe como predicado, entonces lo creamos
autor(libro(_, Autor, _, _), Autor) :-
    vende(libro(_, Autor, _, _), _).
autor(cd(_, Autor, _, _, _), Autor) :-
    vende(cd(_, Autor, _, _, _), _).
% "el autor de este artículo es éste siempre y cuando esté a la venta"
% estamos aplicando polimorfismo en autor/2 (es un predicado polimorfico)
% Articulo puede tener forma de libro o cd, pero no nos interesa

% un poco más de teoría de la wiki de uqbar
% nos dice que los functores nos permiten agrupar individuos en grupos para
% formar algo más abstracto por ejemplo, si tenemos Artículos, podemos
% tener cd's y libros, pero simplemente los agrupamos en Artículos, porque
% es lo que son, Artículos

% estos functores tienen un nombre y una aridad determinada, por ejemplo, para
% nuestro caso tenemos cd de aridad 4 y libro de aridad 5 podemos tener lo siguiente
habitat(Animal, Bioma).

mamifero(Nombre, CantPatas, Alimentacion).
reptil(Nombre, CantPatas, Alimentacion).

habitat(mamifero(tigre, 4, carnivoro), sabana).
habitat(reptil(cocodrilo, 4, carnivoro), pantano).

% lo que hay que resaltar es que no son predicados, son valores, osea, no tienen
% un valor de verdad (True o False)
% no podemos usarlos de raíz, es decir, fuera de un predicado
% tiene que estar dentro de un predicado o (creo que se puede), dentro
% de otro functor



% Practica

% nuestra BASE DE CONOCIMIENTO
% vende/2 (Articulo y Precio)
% autor/2 (Articulo y Autor)

% Extender la base de conocimiento de los siguientes predicados
% 1. libroMásCaro/1: Se cumple para un artículo si es el libro de mayor precio.

% el predicado se usará solo para Libros
% entonces podemos añadir el functor dentro del predicado
libroMasCaro(libro(Titulo, Autor, Genero, Editorial)) :-
    vende(libro(Titulo, Autor, Genero, Editorial), Precio),
    forall(vende(libro(_, _, _, _), OtroPrecio), OtroPrecio =< Precio).
% debemos ligar primero todos los libros que se vende a
% un determinado precio
% luego no aseguramos que para el libro en cuestión no haya ningún otro que
% sea más caro

% 2. curiosidad/1: Se cumple para un artículo si es lo único que hay
% a la venta de su autor.
curiosidad(Articulo) :-
    autor(Articulo, Autor),
    forall(autor(OtroArticulo, OtroAutor), Autor = OtroAutor).

curiosidad(Articulo) :-
    vende(Articulo, _),
    autor(Articulo, Autor),
    not((vende(OtroArticulo, _), autor(OtroArticulo, Autor), Articulo \= OtroArticulo)).
% solución propuesta en el video
% curiosidad es un predicado polimorfico


% 3. sePrestaAConfusión/1: Se cumple para un título si pertenece a
% más de un artículo.
sePrestaAConfusion(Titulo) :-
    titulo(Articulo, Titulo),
    titulo(OtroArticulo, Titulo),
    Articulo \= OtroArticulo.


titulo(libro(Titulo, _, _, _), Titulo) :-
    vende(libro(Titulo, _, _, _), _).
titulo(cd(Titulo, _, _, _, _), Titulo) :-
    vende(cd(Titulo, _, _, _, _), _).
% creamos un predicado polimorfico titulo
% que puede recibir como parámetro un libro o un cd

% 4. mixto/1: Se cumple para los autores de más de un tipo de articulo.
mixto(Autor) :-
    vende(libro(_, Autor, _, _), _),
    vende(cd(_, OtroAutor, _, _, _), _),
    Autor = OtroAutor.
% puede ser una solución

mixo(Autor) :-
    autor(libro(_, _, _, _), Autor), autor(cd(_, _, _, _, _), Autor),
    autor(libro(_, _, _, _), Autor), autor(pelicula(_, _, _), Autor),
    autor(pelicula(_, _, _), Autor), autor(cd(_, _, _, _, _), Autor).

% 5. Agregar soporte para vender Películas con título
% director y género.
vende(pelicula(it, terror, wallace), 1600).
titulo(pelicula(Titulo, _, _), Titulo) :-
    vende(pelicula(Titulo, _, _), _).