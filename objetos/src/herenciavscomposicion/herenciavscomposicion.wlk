// Clase 22 - Herencia vs. Composición
// Link al ejercicio
// https://docs.google.com/document/d/1lp07-hGwuP3q-pCM1jRjOfZ9g6W56Lrx5BFGWZwrvPQ/edit
// PERSONAJES
class Personaje {

	const property fuerza
	const property inteligencia
	var property rol

	// fuerza por diez más extra que depende del rol
	// crear método potencia()
	method potencialOfensivo() = fuerza * 10 + rol.potencialOfensivoExtra()

	method esGroso() = self.esInteligente() || rol.esGroso(self)

	method esInteligente()

}

class Humano inherits Personaje {

	override method esInteligente() = inteligencia > 50

}

class Orco inherits Personaje {

	override method potencialOfensivo() = super() * 1.10

	override method esInteligente() = false

}

// ROLES
object guerrero {

	method potencialOfensivoExtra() = 100

	method esGroso(personaje) = personaje.fuerza() > 50

}

class Cazador {

	var mascota

	method potencialOfensivoExtra() = mascota.potencialOfensivo()

	method esGroso(personaje) = mascota.esLongeva()

}

object brujo {

	method potencialOfensivoExtra() = 0

	method esGroso(personaje) = true

}

class Mascota {

	const fuerza
	const edad
	const tieneGarras

	method potencialOfensivo() = if (tieneGarras) fuerza * 2 else fuerza

	method esLongeva() = edad > 10

}


// 1:03:34