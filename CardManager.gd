class_name CardManager


var escena_carta
var array_scripts 
var rng = RandomNumberGenerator.new()


func instantiate_card():	
	var card = escena_carta.instantiate()
	var n = rng.randi_range(0,2)
	card.set_script(array_scripts[n])
	return card
	
	



func _init():
	escena_carta = preload("res://Carpeta Cartas/Escena Carta/Card Scenes/card.tscn")
	
	array_scripts = [
	preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta1.gd"),
	preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta2.gd"),
	preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta3.gd")
	]




