class_name CardManager


var escena_carta
var array_scripts : Array
var rng = RandomNumberGenerator.new()

func _on_card_effected(id):
	print("Eliminando el Script de la carta con ID: " + str(id))
	_remove_card(id)

func _connect_effect(card):
	card.card_effected.connect(_on_card_effected.bind(card.get_id()))

func instantiate_card():
	var card = escena_carta.instantiate()
	var n = rng.randi_range(0, array_scripts.size() - 1)
	card.set_script(array_scripts[n])
	_connect_effect(card)
	return card
	
	
func _remove_card(id : int):
	array_scripts.pop_at(array_scripts.find(id))


func _init():
	escena_carta = preload("res://Carpeta Cartas/Escena Carta/Card Scenes/card.tscn")
	
	array_scripts = [
	preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta1.gd"),
	preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta2.gd"),
	preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta3.gd"),
	preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta4.gd"),
	preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta5.gd"),
	preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta6.gd")
	]



