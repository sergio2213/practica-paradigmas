mago(draco, pura, [orgullo, inteligencia]).
casa(slytherin).
casa(gryffindor).
caracteriza(gryffindor, amistad).
odia(harry, slytherin).

% 1.
permiteEntrar(slytherin, Mago) :-
    mago(Mago, Sangre, _),
    Sangre \= impura.

permiteEntrar(Casa, Mago) :-
    casa(Casa),
    Casa \= slytherin,
    mago(Mago, _, _).

% 2.
tieneCaracter(Mago, Casa) :-
    mago(Mago, _,CaracteristicasMago),
    caracteriza(Casa, CaracteristicasCasa),
    forall(member(CaracteristicaMago, CaracteristicasMago), member(CaracteristicaMago, CaracteristicasCasa)).

tieneCaracter(Mago, Casa) :-
    mago(Mago, _, CaracteristicasMago),
    casa(Casa),
    forall(caracteriza(Casa, CaracteristicaCasa), member(CaracteristicaCasa, CaracteristicaMago)).
% esta es la solución propuesta en thread

% 3.
casaPosible(Mago, Casa) :-
    mago(Mago, _, _),
    casa(Casa),
    tieneCaracter(Mago, Casa),
    permiteEntrar(Casa, Mago),
    not(odia(Mago, Casa)).

% 4.
cadenaDeAmistades(Magos) :-
    forall(member(Mago, Magos), (mago(Mago, _, Caracteristicas), member(amistad, Caracteristicas))).
% no está completo, falta una condición más

% Copa de la Casa
esDe(harry, gryffindor).

% 5.
esBuenAlumno(Mago).

puntaje(Accion, Puntaje).