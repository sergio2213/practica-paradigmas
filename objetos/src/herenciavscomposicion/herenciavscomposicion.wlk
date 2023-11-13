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

}

class Humano inherits Personaje {

}

class Orco inherits Personaje {

	override method potencialOfensivo() = super() * 1.10

}

// ROLES
object guerrero {

	method potencialOfensivoExtra() = 100

}

class Cazador {

	var mascota

	method potencialOfensivoExtra() = mascota.potencialOfensivo()

}

object brujo {

	method potencialOfensivoExtra() = 0

}

class Mascota {

	const fuerza
	const edad
	const tieneGarras

	method potencialOfensivo() = if (tieneGarras) fuerza * 2 else fuerza
	
	method esLongeva() = edad > 10

}

class Aldea {

}

class Ciudad {

}

// 45:57