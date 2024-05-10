class_name CardManagerStatic

static var scripts : Dictionary
static var rng = RandomNumberGenerator.new()
static var sceneCard = preload("res://Carpeta Cartas/Escena Carta/Card Scenes/card.tscn")


static func _static_init():
	scripts = {
		1 : preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta1.gd"),
		2 : preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta2.gd"),
		3 : preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta3.gd"),
	}


static func _instantiate_card():
	
	print(scripts.size())
	var card= sceneCard.instantiate()
	var n = rng.randi_range(0, scripts.size() - 1)
	card.set_script(scripts.get(n))
	
	return card


static func _remove_card(id : int):
	scripts.erase(id)



