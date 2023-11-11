// Clase 22 - Herencia vs. Composición
// Link al ejercicio
// https://docs.google.com/document/d/1lp07-hGwuP3q-pCM1jRjOfZ9g6W56Lrx5BFGWZwrvPQ/edit

class Personaje {
	var property fuerza
	var property inteligencia
	// guerrero, cazador o brujo
	var property rol
	
	// fuerza por diez más extra que depende del rol
	// crear método potencia()
	
	
}

object guerrero {
	
}

object cazador {
	
}

object brujo {
	
}

class Mascota {
	var property fuerza
	var property edad
	var property tieneGarras
	
}

class Aldea {
	
}

class Ciudad {
	
}

class Guerrero inherits Personaje {
	method extra() = 100
}

class Cazador inherits Personaje {
	method extra() = 111111
}

class Brujo inherits Personaje {
	method extra() = 0
}



// 18:09