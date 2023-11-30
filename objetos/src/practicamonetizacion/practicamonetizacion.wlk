// Clase 24
// Práctica - Monetización
// Link ejercicio: https://docs.google.com/document/d/1lP48bZ8y-K3x-1-o6dhxOOQzWKyMoP8Pqajh56LdAzc/edit#heading=h.1w6qyv2n0qy9

object sistema {
	
	const usuarios = []
	
	method emailsDeUsuariosRicos() = usuarios
		.filter({
			usuario => usuario.esVerificado()
		})
		.sortedBy({
			unUsuario, otroUsuario => unUsuario.saldo() > otroUsuario.saldo()
		})
		.take(100)
		.map({
			usuario => usuario.email()
		})
		
		method cantidadSuperUsuarios() = usuarios.count({
			usuario => usuario.esSuperUsuario()
		})
}

class Usuario {
	const property contenidos = []
	var property esVerificado = false
	const property nombre
	const property email
	
	method saldo() = contenidos.sum({
		contenido => contenido.recaudacion()
	})
	
	method esSuperUsuario() = contenidos
		.count({
			contenido => contenido.esPopular()
		}) >= 10
		
	method crearContenido(contenido) {
		contenidos.add(contenido)
	}
	
}

class Contenido {
	
	const property titulo
	var property vistas = 0
	var property esOfensivo = false
	var property monetizacion
	
	method monetizacion(nuevaMonetizacion) {
		if(!nuevaMonetizacion.puedeAplicarseA(self)) throw new DomainException(message="Monetización no puede aplicarse al contenido")
		monetizacion = nuevaMonetizacion
	}

	// 1:16:40 validamos con initialize
	override method initialize() {
		if(!monetizacion.puedeAplicarseA(self)) throw new DomainException(message="Monetización no puede aplicarse al contenido")
	}
	
	method recaudacion() = monetizacion.recaudacionDe(self)

	method puedeVenderse() = self.esPopular()
	
	method puedeAlquilarse()
	
	method esPopular()
}

const tagsDeModa = ["Sergio", "programacion", "java"]

class Imagen inherits Contenido {
	
	const property tags = []
	
	const property recaudacionMaximaPorPublicidad = 4000
	
	override method esPopular() = tagsDeModa.all({
		tagDeModa => tags.contains(tagDeModa)
	})
	
	override method puedeAlquilarse() = false
}

class Video inherits Contenido {
	
	const property recaudacionMaximaPorPublicidad = 10000
	
	override method esPopular() = vistas > 10000
	
	override method puedeAlquilarse() = true
}

object publicidad {
	
	
	method recaudacionDe(contenido) = (0.05 * contenido.vistas() + self.plus(contenido)).min(contenido.recaudacionMaximaPorPublicidad())
		
	method plus(contenido) = if(contenido.esPopular()) 2000 else 0
	
	method puedeAplicarseA(contenido) = !contenido.esOfensivo()
}

class Donacion {
	var property donaciones
	
	method recaudacionDe(contenido) = donaciones
	
	method puedeAplicarseA(contenido) = true
}

class Descarga {
	
	const property precio
	
	method recaudacionDe(contenido) = precio * contenido.vistas()
	
	method puedeAplicarseA(contenido) = contenido.puedeVenderse()
}

class Alquiler inherits Descarga {
	
	override method precio() = 1.max(super())
	
	override method puedeAplicarseA(contenido) = super(contenido) && contenido.puedeAlquilarse()
}



