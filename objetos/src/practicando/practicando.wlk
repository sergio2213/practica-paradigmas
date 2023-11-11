class Estudiante inherits Persona {
	const legajo
		
	method legajo() = legajo
	override method ocupacion() = "Estudiante"
	
}

class Profesor inherits Persona {
	var materia
	
	method materia() = materia
	method cambiarDeMateria(nuevaMateria) {
		materia = nuevaMateria
	}
	method ensenia() = materia.nombre()
	override method ocupacion() = "Profesor"
}

class Persona {
	const nombre
	const apellido
	
	method nombre() = nombre
	method apellido() = apellido
	method ocupacion()
}

class Materia {
	const nombre
	
	method nombre() = nombre
}