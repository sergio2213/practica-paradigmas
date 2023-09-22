% PRÁCTICA: Festivales de Rock

% Tenemos que organizar un sistema para analizar festivales de rock
% porque… Bueno, porque sí. Nadie lee esta parte del enunciado de todos modos.

% Cuestión que partimos de una base de conocimiento con algunos predicados
% (completamente inversible) predefinidos que modelan la información que
% fuimos recopilando de los diversos festivales:

% festival(NombreDelFestival, Bandas, Lugar).
% Relaciona el nombre de un festival con la lista de los nombres de bandas
% que tocan en él y el lugar dónde se realiza.
festival(lollapalooza, [gunsAndRoses, theStrokes, ..., littoNebbia], hipodromoSanIsidro).

% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipodromoSanIsidro, 85000, 3000).

% banda(nombre, nacionalidad, popularidad).
% Relaciona una banda con su nacionalidad y su popularidad.
banda(gunsAndRoses, eeuu, 69420).

% entradaVendida(NombreDelFestival, TipoDeEntrada).
% Indica la venta de una entrada de cierto tipo para el festival 
% indicado.
% Los tipos de entrada pueden ser alguno de los siguientes: 
%     - campo
%     - plateaNumerada(Fila)
%     - plateaGeneral(Zona).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

% plusZona(Lugar, Zona, Recargo)
% Relacion una zona de un lugar con el recargo que le aplica al precio de las
% plateas generales.
plusZona(hipodromoSanIsidro, zona1, 1500).

% Se pide definir los siguientes predicados:

% 1. itinerante/1: Se cumple para los festivales que ocurren en más de un
% lugar, pero con el mismo nombre y las mismas bandas en el mismo orden.
itinerante(Festival) :-  
    festival(Festival, Banda, Lugar),
    festival(Festival, Banda, OtroLugar),
    Lugar \= OtroLugar.

% lo hice bien :)

% 2. careta/1: Decimos que un festival es careta si no tiene campo o si es
% el personalFest.
careta(Festival) :-
    festival(Festival, _, _),
    not(entradaVendida(Festival, campo)).

careta(personalFest).
% este último no lo hice exactamente como en el video

% 3. nacAndPop/1: Un festival es nac&pop si no es careta y todas las bandas
% que tocan en él son de nacionalidad argentina y tienen popularidad mayor
% a 1000.
nacAndPop(Festival) :-
    festival(Festival, Bandas, _), 
    not(careta(Festival)),
    forall(member(Banda, Bandas), (banda(Banda, argentina, Popularidad), Popularidad > 1000)).   


% 4. sobrevendido/1: Se cumple para los festivales que vendieron más entradas
% que la capacidad del lugar donde se realizan.

% Nota: no hace falta contemplar si es un festival itinerante.
sobrevendido(Festival) :-
    festival(Festival, _, Lugar),
    lugar(Lugar, Capacidad, _),
    findall(1, entradaVendida(Festival, _), Vendidas),
    sumlist(Vendidas, Total),
    Total > Capacidad.

sobrevendido(Festival) :-
    festival(Festival, _, Lugar),
    lugar(Lugar, Capacidad, _),
    findall(Entrada, entradaVendida(Festival, Entrada), Entradas),
    length(Entradas, Cantidad),
    Cantidad > Capacidad.

% 5. recaudacionTotal/2: Relaciona un festival con el total recaudado con la
% venta de entradas. Cada tipo de entrada se vende a un precio diferente:
% - El precio del campo es el precio base del lugar donde se realiza el festival.
% - La platea general es el precio base del lugar más el plus que se p aplica a la zona. 
% - Las plateas numeradas salen el triple del precio base para las filas de
% atrás (>10) y 6 veces el precio base para las 10 primeras filas.

% Nota: no hace falta contemplar si es un festival itinerante.
recaudacionTotal(Festival, TotalRecaudado) :-
    festival(Festival, _, Lugar),
    lugar(Lugar, _, PrecioBase),
    findall(PrecioFinal, precio(tipoEntrada, PrecioBase, PrecioFinal), Precios),
    sumlist(Precios, TotalRecaudado).

precio(campo, PrecioBase, PrecioFinal).
precio(plateaGeneral, PrecioBase, PrecioFinal) :-
    plusZona(_, plateaGeneral, Recargo),
    PrecioFinal is PrecioBase + Recargo.
precio(plateaNumerada, PrecioBase, PrecioFinal) :-
    plusZona(_, plateaNumerada, Recargo),
    PrecioFinal is PrecioBase * 3.
% hecha por mí

recaudacionTotal(Festival, Recaudacion) :-
    festival(Festival, _, Lugar),
    findall(Precio, (entradaVendida(Festival, Entrada), precio(Entrada, Lugar, Precio)), Precios),
    sumlist(Precios, Recaudacion).

precio(campo, Lugar, PrecioBase) :-
    lugar(Lugar, _, PrecioBase).

precio(plateaGeneral(Zona), Lugar, Precio) :-
    lugar(Lugar, _, PrecioBase),
    plusZona(Lugar, Zona, Plus),
    Precio is PrecioBase + Plus.

precio(plateaNumerada(Fila), Lugar, Precio) :-
    Fila =< 10,
    lugar(Lugar, _, PrecioBase),
    Precio is PrecioBase * 6.

precio(plateaNumerada(Fila), Lugar, Precio) :-
    Fila > 10,
    lugar(Lugar, _, PrecioBase),
    Precio is PrecioBase * 3.
% solución propuesta en el video
  
% 6. delMismoPalo/2: Relaciona dos bandas si tocaron juntas en algún
% recital o si una de ellas tocó con una banda del mismo palo que la otra, pero más popular.

delMismoPalo(UnaBanda, OtraBanda) :-
    tocoCon(UnaBanda, OtraBanda).

delMismoPalo(UnaBanda, OtraBanda) :-
    tocoCon(UnaBanda, TercerBanda),
    banda(TercerBanda, _, PopularidadDeLaTercerBanda),
    banda(OtraBanda, _, PopularidadDeLaOtraBanda),
    PopularidadDeLaTercerBanda > PopularidadDeLaOtraBanda,
    delMismoPalo(TercerBanda, OtraBanda).

tocoCon(UnaBanda, OtraBanda) :-
    festival(_, Bandas, _),
    member(UnaBanda, Bandas),
    member(OtraBanda, Bandas),
    UnaBanda \= OtraBanda.
