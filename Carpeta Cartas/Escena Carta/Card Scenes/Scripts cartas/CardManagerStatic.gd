class_name CardManagerStatic

static var cartas : Dictionary
static var rng = RandomNumberGenerator.new()



static func _static_init():
	cartas = {
		1 : preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta1.gd"),
		2 : preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta2.gd"),
		3 : preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta3.gd"),
	}
	
	

static func _instantiate_card():
	var n = rng.randi_range(0, cartas.size() - 1)
	return cartas.get(n)
	

