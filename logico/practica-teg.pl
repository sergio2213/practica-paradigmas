% Nos piden modelar una herramienta para analizar el tablero de un juego de
% Táctica y Estratégia de Guerra. Para eso ya contamos con los siguientes
% predicados completamente inversibles en nuestra base de conocimiento:

% Se cumple para los jugadores.
jugador(Jugador).
% Ejemplo:
% jugador(rojo).

% Relaciona un país con el continente en el que está ubicado,
ubicadoEn(Pais, Continente).
% Ejemplo:
% ubicadoEn(argentina, américaDelSur).

% Relaciona dos jugadores si son aliados.
aliados(UnJugador, OtroJugador).
% Ejemplo:
% aliados(rojo, amarillo).

% Relaciona un jugador con un país en el que tiene ejércitos.
ocupa(Jugador, Pais).
% Ejemplo:
% ocupa(rojo, argentina).

% Relaciona dos países si son limítrofes.
limitrofes(UnPais, OtroPais).
% Ejemplo:
% limítrofes(argentina, brasil).


% Se pide modelar los siguientes predicados, de forma tal que sean completamente inversibles:

% 1. tienePresenciaEn/2: Relaciona un jugador con un continente del cual ocupa, al menos, un país.
tienePresenciaEn(Jugador, Continente) :-
    ocupa(Jugador, Pais),
    ubicadoEn(Pais, Continente).

% 2. puedenAtacarse/2: Relaciona dos jugadores si uno ocupa al menos un país limítrofe a algún país ocupado por el otro.
puedenAtacarse(Jugador, OtroJugador) :-
    ocupa(Jugador, Pais),
    ocupa(OtroJugador, OtroPais),
    limitrofes(Pais, OtroPais).
    
% 3. sinTensiones/2: Relaciona dos jugadores que, o bien no pueden atacarse, o son aliados.
sinTensiones(Jugador, OtroJugador) :- aliados(Jugador, OtroJugador).    
sinTensiones(Jugador, OtroJugador) :-
    jugador(Jugador),
    jugador(OtroJugador),
    not(puedenAtacarse(Jugador, OtroJugador)).
% Jugador y OtroJugador llegan ligados al predicado not

% 4. perdió/1: Se cumple para un jugador que no ocupa ningún país.
perdio(Jugador) :- jugador(Jugador), not(ocupa(Jugador, _)).
% un Jugador perdió, si es un jugador y no ocupa ningún país

% 5. controla/2: Relaciona un jugador con un continente si ocupa todos los países del mismo.
controla(Jugador, Continente) :-
    jugador(Jugador),
    ubicadoEn(_, Continente),
    forall(ubicadoEn(Pais, Continente), ocupa(Jugador, Pais)).
controla(Jugador, Continente) :-
    jugador(Jugador),
    ubicadoEn(_, Continente),
    not((ubicadoEn(Pais, Continente), not(ocupa(Jugador, Pais)))).
% las dos opciones son válidas, son equivalentes

% 6. reñido/1: Se cumple para los continentes donde todos los jugadores ocupan algún país.
% renido(Continente) :-
%     not((ubicadoEn(_, Continente), not(ocupa(Jugador, Pais)))).
% renido(Continente) :-
%     ubicadoEn(_, Continente),
%     ocupa(Jugador, Pais).
% lo hice mal, abajo está bien
renido(Continente) :-
    ubicadoEn(_, Continente),
    forall(jugador(Jugador), (ocupa(Jugador, Pais), ubicadoEn(Pais, Continente))).


% 7. atrincherado/1: Se cumple para los jugadores que ocupan países en un único continente.
% atrincherado(Jugador) :-
%     ocupa(Jugador, Pais),
%     ocupa(Jugador, OtroPais),
%     ubicadoEn(Pais, Continente),
%     ubicadoEn(OtroPais, Continente).
% atrincherado(Jugador) :-
%     tienePresenciaEn(Jugador, Continente),
%     tienePresenciaEn(Jugador, OtroContinente),
%     Continente == OtroContinente.
atrincherado(Jugador) :-
    jugador(Jugador),
    ubicadoEn(_, Continente),
    forall(ocupa(Jugador, Pais), ubicadoEn(Pais, Continente)).



% 50:45
% 8. puedeConquistar/2: Relaciona un jugador con un continente si no lo controla, pero
% todos los países del continente que le falta ocupar son limítrofes a alguno que sí ocupa
% y pertenecen a alguien que no es su aliado.
puedeConquistar(Jugador, Continente) :-
    jugador(Jugador),
    ubicadoEn(_, Continente),
    not(controla(Jugador, Continente)).