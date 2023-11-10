// Herencia - Clase 21
// keywords: inherits
// la herencia es un tema accesorio
// lo que debemos priorizar es el polimorfismo, encapsulamiento y delegación
// creamos la clase Tanque
class Tanque {
	const armas = []
	const tripulantes = 2
	var salud = 1000
	var property prendidoFuego = false
	
	method emiteCalor() = prendidoFuego || tripulantes > 3
	
	// elegimos que salud no esté expuesto,
	// que solo se pueda modificar a través del siguiente método
	method sufrirDanio(danio) {
		salud -= danio
	}
	
	method atacar(objetivo) {
		armas.anyOne().dispararA(objetivo)
	}

}

class Arma {
	method dispararA(objetivo) {
		
	}
}

// no necesito tener varios objetos lanzaLlamas,
// con tener uno es suficiente
//object lanzaLlamas {
//	method dispararA(objetivo) {
//		objetivo.prendidoFuego(true)
//	}
//}

class Recargable {
	var cargador = 100
	
	method recargar() {
		cargador = 100
	}
	
	method agotada() = cargador <= 0
}

// se refactoriza
// antes de la clase Rociador
//class LanzaLlamas inherits Recargable {
//	
//	method disparar(objetivo) {
//		cargador =- 20
//		objetivo.prendidoFuego(true)
//	}
//}

class LanzaLlama inherits Rociador {
	override method causarEfecto(objetivo) {
		objetivo.prendidoFuego(true)
	}
}

class Misil {
	const potencia
	var agotada = false
	
	method agotada() = agotada
	
	// el daño es igual a la potencia del misil
	method dispararA(objetivo) {
		agotada = true
		objetivo.sufrirDanio(potencia)
	}
}

class Metralla inherits Recargable {
	const calibre
	
	method dispararA(objetivo) {
		cargador -= 10
		if(calibre > 50) {
			objetivo.sufrirDanio(calibre / 4)
		}
	}
}

// una clase a la que no podemos instanciar la llamamos abstracta
// la usamos para compartir lógica

// Redefinición o sobreescritura
// keywords: override
// sirve para especificar

class MisilTermico inherits Misil {
	override method dispararA(objetivo) {
		if(objetivo.emiteCalor()) {
			// con esto invocamos al método dispararA(objetivo) de la clase Misil
			// solo lo puedo usar en métodos 'overrideados'
			super(objetivo)
		}
	}
}

// Practica
// Repaso self y super (1:00:20 por si es necesario repasarlo)
// Extender el modelo para incluir
// - Tanques blindados
// - Matafuegos

class TanqueBlindado inherits Tanque {
	const blindaje = 200
	
	override method emiteCalor() = false
	
	override method sufrirDanio(danio) {
		if(danio > blindaje) {
			super(danio - blindaje)
		}
	}
}

// antes de la clase Rociador
//class Matafuego inherits Recargable {
//	method dispararA(objetivo) {
//		cargador =- 20
//		objetivo.prendidoFuego(false)
//	}
//}

class Matafuego inherits Rociador {
	override method causarEfecto(objetivo) {
		objetivo.prendidoFuego(false)
	}
}

class Rociador inherits Recargable {
	method dispararA(objetivo) {
		cargador =-20
		self.causarEfecto(objetivo)
	}
	
	// creamos un método abstracto
	method causarEfecto(objetivo)
}



