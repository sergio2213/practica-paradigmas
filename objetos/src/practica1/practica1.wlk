object julieta {

	var tickets = 15
	var cansancio = 0

	// Azúcar sintáctico
	// var property tickets = 15
	// al hacer esto se crean automáticamente sus respectivos getter y setter
	method fuerza() = 80 - cansancio

	method punteria() = 20

	method tickets() = tickets

	method tickets(nuevoValor) {
		tickets = nuevoValor
	}

	method jugar(juego) {
		tickets = tickets + juego.ticketsGanados(self)
		cansancio = cansancio + juego.cansancioAcumulado()
	}

	method puedeCanjear(premio) = tickets >= premio.valor()

}

object ositoDePelucha {

	method valor() = 45

}

object taladro {

	var property valor = 200

}

object tiroAlBlanco {

	method ticketsGanados(jugador) = (jugador.punteria() / 10).roundUp()

	method cansancioAcumulado() = 3

}

object pruebaDeFuerza {

	method ticketsGanados(jugador) = if (jugador.fuerza() >= 75) 20 else 0

	method cansancioAcumulado() = 8

}

object ruedaDeLaFortuna {

	var aceitada = true

	method aceitada() = aceitada

	method aceitada(nuevoValor) {
		aceitada = nuevoValor
	}

	method ticketsGanados(jugador) = 0.randomUpTo(20).roundUp()

	method cansancioAcumulado() = if (not aceitada) 1 else 0

}

object gerundio {

	// no es necesario agregar los atributos
	method jugar() {
	}

	method puedeCanjear() = true

}

