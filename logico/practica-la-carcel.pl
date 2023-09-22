% La Cárcel

% Gestionar una cárcel no es tarea fácil y para lograrlo requerimos la
% ayuda de un programa en Prolog. Se cuenta con la siguiente base de
% conocimiento, que contiene información acerca de varias cárceles y
% qué personas residen allí: tanto guardias como prisioneros.

% De los guardias sabemos su nombre y de los prisioneros, su nombre y
% los crímenes que cometieron. Se contemplan tres tipos de crímenes:
% Homicidio, que registra la víctima.
% Narcotráfico, que indica la lista de drogas traficadas.
% Robo, que relaciona cuánto dinero en dólares fue robado.

% Por ejemplo, una base de conocimiento de referencia podría verse así:

% guardia(Nombre)
guardia(bennett).
guardia(mendez).
guardia(george).

% prisionero(Nombre, Crimen)
prisionero(piper, narcotrafico([metanfetaminas])).
prisionero(alex, narcotrafico([heroína])).
prisionero(alex, homicidio(george)).
prisionero(red, homicidio(rusoMafioso)).
prisionero(suzanne, robo(450000)).
prisionero(suzanne, robo(250000)).
prisionero(suzanne, robo(2500)).
prisionero(dayanara, narcotrafico([heroina, opio])).
prisionero(dayanara, narcotrafico([metanfetaminas])).


% Teniendo en cuenta la base de conocimiento planteada, se pide resolver
% los siguientes puntos, asegurándose de implementar todos los predicados
% que se piden de modo que sean completamente inversibles. Recuerden que
% no está permitido el uso de OR (;), CUT (!) y que los usos de findall/3
% deben ser restringidos a las situaciones donde es indispensable.

% Dado el predicado controla/2:
% controla(Controlador, Controlado)

controla(piper, alex).
controla(bennett, dayanara).
% controla(Guardia, Otro) :-
%     prisionero(Otro,_),
%     not(controla(Otro, Guardia)).

% Indicar, justificando, si es inversible y, en caso de no serlo, dar
% ejemplos de las consultas que NO podrían hacerse y corregir la implementación
% para que se pueda.

% NO es inversible para el primer parámetro. SÍ para el segundo.
% Consultas que no podrían hacerse:
% controla(Guardia, alex).
% Corrección:
controla(Guardia, Otro) :-
    guardia(Guardia),
    prisionero(Otro, _),
    not(controla(Otro, Guardia)).


% 2. conflictoDeIntereses/2: relaciona a dos personas distintas (ya sean
% guardias o prisioneros) si no se controlan mutuamente y existe algún tercero
% al cual ambos controlan.

conflictoDeIntereses(Persona, OtraPersona) :-
    controla(Persona, Tercero),
    controla(OtraPersona, Tercero),
    not(controla(Persona, OtraPersona)),
    not(controla(OtraPersona, Persona)),
    Persona \= OtraPersona.

% 3. peligroso/1: Se cumple para un preso que sólo cometió crímenes graves.
% - Un robo nunca es grave.
% - Un homicidio siempre es grave.
% - Un delito de narcotráfico es grave cuando incluye al menos 5 drogas a
% la vez, o incluye metanfetaminas.

peligroso(Prisionero) :-
    prisionero(Prisionero, homicidio(_)).

peligroso(Prisionero) :-
    prisionero(Prisionero, narcotrafico(Drogas)),
    length(Drogas, Tamanio),
    Tamanio >= 5.

peligroso(Prisionero) :-
    prisionero(Prisionero, narcotrafico(Drogas)),
    member(metanfetaminas, Drogas).

% NO, porque puede tener algún crímen que no sea grave, y será considerado peligroso
% Solución
peligroso(Prisionero) :-
    prisionero(Prisionero, _),
    forall(prisionero(Prisionero, Crimen), grave(Crimen)).

grave(homicidio(_)).
grave(narcotrafico(Drogas)) :-
    length(Drogas, Tamanio),
    Tamanio >= 5.
grave(narcotrafico(Drogas)) :-
    member(metanfetaminas, Drogas).

% 4. ladronDeGuanteBlanco/1: Aplica a un prisionero si sólo cometió robos
% y todos fueron por más de $100.000.

ladronDeGuanteBlanco(Prisionero) :-
    prisionero(Prisionero, robo(Total)),
    Total > 100000.

ladronDeGuanteBlanco(Prisionero) :-
    prisionero(Prisionero, _),
    forall(prisionero(Prisionero, robo(Total)), Total > 10000).

% NO

% Solución propuesta en el video
ladronDeGuanteBlanco(Prisionero) :-
    prisionero(Prisionero, _),
    forall(prisionero(Prisionero, Crimen), (monto(Crimen, Monto), Monto > 100000)).

monto(robo(Monto), Monto).

% 5. condena/2: Relaciona a un prisionero con la cantidad de años de condena
% que debe cumplir. Esto se calcula como la suma de los años que le aporte
% cada crimen cometido, que se obtienen de la siguiente forma:
% - La cantidad de dinero robado dividido 10.000.
% - 7 años por cada homicidio cometido, más 2 años extra si la víctima era un guardia.
% - 2 años por cada droga que haya traficado.

condena(Prisionero, AniosCondena) :-
    prisionero(Prisionero, _),
    findall(Pena, (prisionero(Prisionero, Crimen), pena(Crimen, Pena)), Penas),
    sumlist(Penas, AniosCondena).

pena(robo(Monto), Pena) :- Pena is Monto / 10000.
pena(homicidio(Persona), 9) :- guardia(Persona).
pena(homicidio(Persona), 7) :- not(guardia(Persona)).
pena(narcotrafico(Drogas), Pena) :- length(Drogas, Cantidad), Pena is Cantidad * 2.
    


% 6. capoDiTutiLiCapi/1: Se dice que un preso es el capo de todos los capos cuando
% nadie lo controla, pero todas las personas de la cárcel (guardias o prisioneros)
% son controlados por él, o por alguien a quien él controla (directa o indirectamente).

capoDiTutiLiCapi(Capo) :-
    controla(Capo, guardia(Guardia)),
    controla(Capo, prisionero(Prisionero,_)),
    controla(Guardia, Otro),
    controla(Prisionero, Otro),
    not(controla(_, Capo)),
    Otro \= Capo.

% Solución planteada en el video
capoDiTutiLiCapi(Capo) :-
    prisionero(Capo, _),
    not(controla(_, Capo)),
    forall((persona(Persona), Capo \= Persona), controlaDirectaOIndirectamente(Capo, Persona)).

persona(Persona) :- guardia(Persona).
persona(Persona) :- prisionero(Persona, _).

controlaDirectaOIndirectamente(Uno, Otro) :- controla(Uno, Otro).
controlaDirectaOIndirectamente(Uno, Otro) :-
    controla(Uno, Tercero),
    controlaDirectaOIndirectamente(Tercero, Otro).
