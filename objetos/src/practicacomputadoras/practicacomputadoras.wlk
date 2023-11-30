// COMPUTADORAS
class SuperComputadora {
	const property equipos = []
	
	var property totalComplejidadResuelta = 0
	
	method estaActivo() = true
	
	method equiposActivos() = equipos.filter({
		equipo => equipo.estaActivo()
	})
	
	method poderComputo() = self.equiposActivos().sum({
		equipoActivo => equipoActivo.poderComputo()
	})
	
	method consumo() = self.equiposActivos().sum({
		equipoActivo => equipoActivo.consumo()
	})
	
	method estaMalConfigurada() = self.equipoQueMasComputa() != self.equipoQueMasConsume()
	
	method equipoQueMasComputa() = self.equiposActivos().max({
		equipo => equipo.poderComputo()
	})
	
	method equipoQueMasConsume() = self.equiposActivos().max({
		equipo => equipo.consumo()
	})
	
	method computarProblema(problema) {
		if(problema.complejidad() > self.poderComputo()) {
			self.equiposActivos().forEach({
				equipoActivo => equipoActivo.computarProblema(new Problema(complejidad=problema.complejidad() / self.equiposActivos()))
			})
		}
		totalComplejidadResuelta =+ problema.complejidad()
	}
}

class Equipo {
	
	var property estaQuemado = false
	var property modo = standard
	
	method estaActivo() = !estaQuemado && self.poderComputo() > 0
	
	method poderComputo() = modo.poderComputoDe(self)
	method consumo() = modo.consumoDe(self)
	
	method consumoBase()
	method poderComputoBase()
	
	method poderComputoExtraPorOverclock()
	
	method computarProblema(subProblema) {
		if(subProblema.complejidad() > self.poderComputo())
			throw new DomainException(message="No puede computar sub-problema")
		modo.realizoComputo(self)
	}
}

class A105 inherits Equipo {
	
	override method consumoBase() = 300
	
	override method poderComputoBase() = 600
	
	override method poderComputoExtraPorOverclock() = self.poderComputo() * 0.3
	
	override method computarProblema(subProblema) {
		super(subProblema)
		if(subProblema.complejidad() < 5)
			throw new DomainException(message="Error de construcción")
	}
	
}

class B2 inherits Equipo {
	
	var property cantMicrochip
	
	override method consumoBase() = 50 * cantMicrochip + 10
	
	override method poderComputoBase() = (100 * cantMicrochip).max(800)
	// el profe puso 800.min(100 * cantMicrochip)
	
	override method poderComputoExtraPorOverclock() = 20 * cantMicrochip
	
	

}



// PROBLEMAS
class Problema {
	const property complejidad
}

// MODOS
object standard {
	
	method consumoDe(equipo) = equipo.consumoBase()
	
	method computoDe(equipo) = equipo.poderComputoBase()
	
	method realizoComputo(equipo) {
		
	}
}

class Overclock {
	
	var property usosRestantes
	
	override method initialize() {
		if(usosRestantes < 0)
			throw new DomainException(message="Se inicializó con usos restantes negativo")
	}
	
	method consumoDe(equipo) = equipo.consumoBase() * 2
	
	method computoDe(equipo) = equipo.poderComputoBase() + equipo.poderComputoExtraPorOverclock()
	
	method realizoComputo(equipo) {
		if(usosRestantes == 0) {
			equipo.estaQuemado(true)
			throw new DomainException(message="El equipo está quemado")
		}
		usosRestantes =- 1
	}
}

class Ahorro {
	
	var property computosRealizados = 0
	
	method consumoDe(equipo) = 200
	
	method computoDe(equipo) = equipo.poderComputoBase() * (self.consumoDe(equipo) / equipo.consumoBase())
	
	method periodicidadDeError() = 17
	
	method realizoComputo(equipo) {
		computosRealizados += 1
		if(computosRealizados % self.periodicidadDeError() == 0)
			throw new DomainException(message="Falla")
	}
}

class APruebaDeFallos inherits Ahorro {
	override method computoDe(equipo) = super(equipo) / 2
	
	override method periodicidadDeError() = 100
	
}




