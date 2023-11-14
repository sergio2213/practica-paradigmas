// Clase 22 - Herencia vs. Composición
// Link al ejercicio
// https://docs.google.com/document/d/1lp07-hGwuP3q-pCM1jRjOfZ9g6W56Lrx5BFGWZwrvPQ/edit
// PERSONAJES
class Personaje {

	const property fuerza
	const property inteligencia
	var property rol

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

class Ejercito {

	var property miembros = []

	method atacar(zona) {
		
		if(zona.potencialDefensivo() < self.potencialOfensivo()) {
			zona.estaOcupadaPor(self)
		}
		
	}
	
	method potencialOfensivo() = miembros.sum({
		miembro => miembro.potencialOfensivo()
	})

}

class Zona {
	
	var habitantes
	
	method potencialDefensivo() = habitantes.potencialOfensivo()
	
	method estaOcupadaPor(ejercito) {
		habitantes = ejercito
	}
}

class Ciudad inherits Zona {
	
	override method potencialDefensivo() = super() + 300
	
}

class Aldea inherits Zona {
	
	const maxHabitantes = 50
	
	override method estaOcupadaPor(ejercito) {
		if(ejercito.miembros().size() > maxHabitantes) {
			const nuevosHabitantes = ejercito.miembros()
				.sortedBy({
					x, y => x.potencialOfensivo() > y.potencialOfensivo()
				})
				.take(10)
			super(new Ejercito(miembros = nuevosHabitantes))
			// ejercito.miembros().removeAll(nuevosHabitantes) con esto descomentado da warning
		} else {
			super(ejercito)
		}
	}
	
}

