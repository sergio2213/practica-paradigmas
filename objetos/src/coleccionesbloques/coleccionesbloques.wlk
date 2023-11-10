// Listas
// es un objeto que que puede entender los siguiente mensajes
// size()
// head()
// filter(criterio)
// map(transformacion)
// all(criterio)
// any(criterio)
// sum()
// estos mensajes causan efecto sobre la lista
// add(elemento)
// remove(elemento)
// forEach(operacion)
// trataremos de no causar efecto sobre las listas
// Ejemplo de Lista
class Estudiante {

	method saludar() {
	}

	method estudiar() {
	}

	method esEstudioso() {
	}

}

// const estudiantes = [new Estudiante(), new Estudiante()]
// Ejemplo de filter(criterio)
// para usar un criterio tenemos que tener listo nuestro objeto
// adentro de dicho objeto debe tener un método apply(objeto)
// que se pasa por parámetro un objeto que queremos evaluar
object criterioEsEstudioso {

	method apply(estudiante) = estudiante.esEstudioso()

}

// ya podemos usar el método filter con nuestro criterio
// estudiantes.filter(criterioEsEstudioso)
// Azúcar sintáctico
// estudiantes.filter({estudiante => estudiante.esEstudioso()})
// Otro azúcar sintáctico
// estudiantes.filter { estudiante => estudiante.esEstudioso() }
// Práctica
// Modelar un corral de vacas que permita:
// - Consultar cuántos litros de leche podemos ordeñar de vacas contentas
// - Saber si todas las vacas están contentas
// - Ordeñar todas las vacas contentas
// - Podemos agregar cabras
class Vaca {

	method litrosDeLeche() {
	}

	method estaContenta() {
	}

	method ordeniar() {
	}

}

class Corral {

	const vacas = []

	method lecheDisponible() = vacas.filter({ vaca => vaca.estaContenta() }).sum({ vaca => vaca.litrosDeLeche() })

	method todasContentas() = vacas.all({ vaca => vaca.estaContenta() })

	method ordeniarVacasContentas() = vacas.forEach({ vaca =>
		if (vaca.estaContenta()) vaca.ordeniar()
	})

}

