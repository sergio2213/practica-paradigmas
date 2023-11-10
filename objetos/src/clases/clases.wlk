// Clase 19 - Clases

// 3 propósitos
// - permiten instanciar objetos
// - definen atríbutos
// - proveen métodos

// Es una herramientas para construir objetos
// Ejemplo de creación de una clase

class Estudiante {
	var property amigos = 1
	
	method agregarUnAmigo() {
		amigos = amigos + 1
	}
}

// desde la consola podemos instancias un objeto de tipo Estudiante
// const sergio = new Estudiante()

// puedo instanciar un objeto con otro valor de atributo
// const alvaro = new Estudiante(amigos = 3)

// Referencias y Garbage Collection
// cuando perdemos la referencia a un objeto, el garbage collector
// se encarga de eliminar dicho objeto para que no siga ocupando
// espacio en memoria