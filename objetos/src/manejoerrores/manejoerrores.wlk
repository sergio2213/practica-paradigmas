// Clase 23 - Manejo de errores
// "Todo método debe hacer lo que promete, o no hacer nada y explotar"
// Confucio (mentira)


// Ejemplo de la impresora
// preguntar si puede imprimir
// si es true, mandamos a imprimir

// O hacer que el método imprimir retorne un booleano que me permita saber si pudo imprimir o no (min. 31)

// O podemos hacer que un método lance una excepción cuando ocurra un problema
// throw new Exception(message = "hay un error")
// se instancia un objeto de la clase Exception
// se detiene el proceso de ejecución en todos los niveles

// Uso de try-catch
// try
// lo que encierre el try es lo que intentará ejecutar

// catch
// si falla al intentar ejecutar todo el bloque del try
// se ejecutará lo que encierre el bloque catch

// Podemos crear nuestras propias excepciones

// Podemos usar tantos catch como querramos
// casos más específicos van más arriba

// Podemos tener un bloque que se va a ejecutar sí o sí
// hala excepción o no
// then always

// Ejemplo
class Impresora {
	method imprimir() {
		try {
			// intentar ejecutar algo
		} catch error: SinCargaException {
			// ejecutar en caso de hallarse una excepción dentro del try
		} catch error {
			//
		} then always {
			//
		}
	}
}

class Cartucho {
	method extraer() {
		// a modo ejemplo, debería evaluar la cantidad de tinta
		if(2 > 0) {
			throw new SinCargaException(carga = "sin carga")
		}
	}
}

class SinCargaException inherits DomainException {
	const property carga
}

// Malas prácticas
// - tener un catch vacío