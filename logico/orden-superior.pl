% PREDICADOS DE ORDEN SUPERIOR

% es un predicado que recibe como parámetro otro predicado
amigo(sergio, alvaro).
amigo(alvaro, jeremias).
amigo(gustavo, gabriel).

% quiero consultar sobre aquellos que no son amigos de Sergio
noAmigo(sergio) :- amigo(_, OtroAmigo), not(amigo(sergio, OtroAmigo)).

% CUANTIFICADOR UNIVERSAL
% NOT

esMalo(feinmann). 
esMalo(hadad). 
esMalo(echecopar).
esMalo(macri).

% Consultas existenciales
% esMalo(_).

% INVERSIBILIDAD
esPersona(feinmann).
esPersona(hadad).
esPersona(echecopar).
esPersona(macri).

% 1.
% esBueno(Persona) :- not(esMalo(Persona)).

% si consultamos
% esBueno(macri) nos sará false

% si consultamos
% esBueno(pepe) nos dará true, porque no está definido que esMalo(pepe), por lo tento es false
% entonces esBueno(pepe) dará true

% si consultamos
% esBueno(Alguien) nos dará false, ¿por qué?
% partimos de ya existe alguien que haga que se cumpla que esMalo(Alguien) sea true
% entonces al invertir nos dará false

% podemos modificar 1. de esta forma
% 2.
esBueno(Persona) :-
    esPersona(Persona),
    not(esMalo(Persona)).

% dentro de la condición nos aseguramos de tener aquellas que cumplan esPersona/1
% entonces si consultamos nuevamente
% esBueno(pepe) nos dará false

% FORALL
% se piensa cuándo se verifica una condición
% recibe dos consultas

% tenemos la siguiente base de conocimiento

dulce(chocolate).
dulce(caramelo).
dulce(durazno).
amargo(radicheta).
amargo(cebada).

leGusta(roque, chocolate).
leGusta(roque, radicheta).
leGusta(pepe, cebada).

colorDePelo(roque, colorado).
colorDePelo(pepe, castanio).

vive(roque, buenosAires).
vive(pepe, mendoza).
vive(lucas, salliquelo).

ciudadGrande(buenosAires).
ciudadGrande(mendoza).

% queremos definir esTierno/1 donde una persona es tierna si todas las cosas
% que le gustan son dulces

esTierno(Persona) :- leGusta(Persona, _), forall(leGusta(Persona, Alimento), dulce(Alimento)).

% definir el predicado alimentoCurioso/1, un alimento es curioso si solamente
% le gusta a gente de pelo colorado

alimentoCurioso(Alimento) :- forall(leGusta(Persona, Alimento), colorDePelo(Persona, colorado)).

% probando
edad(sergio, 31).
edad(silvia, 31).
edad(alvaro, 35).
edad(matias, 25).
edad(lelia, 26).

mayoresDeTreinta(Persona) :- edad(Persona, Edad), Edad > 30.

% FINDALL
