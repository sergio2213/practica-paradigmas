// Clase 22 - Herencia vs. Composición
// Link al ejercicio
// https://docs.google.com/document/d/1lp07-hGwuP3q-pCM1jRjOfZ9g6W56Lrx5BFGWZwrvPQ/edit

class Raza {
	var property fuerza
	var property inteligencia
	var property rol // guerrero, cazador o brujo
	
	// fuerza por diez más extra que depende del rol
	// crear método potencia()
	
	
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

class Guerrero inherits Raza {
	method extra() = 100
}

class Cazador inherits Raza {
	method extra() = 111111
}

class Brujo inherits Raza {
	method extra() = 0
}


// 18:09