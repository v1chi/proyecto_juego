extends Node



const PATH_ESCENA_CARTA : String = "res://Carpeta Cartas/Escena Carta/Card Scenes/card.tscn"
var rng = RandomNumberGenerator.new()

var carta1 : AbstractCard 
var carta2 : AbstractCard 
var data_cartas : DataCartas
var array_no_repetidos : Array = []

func _ready():
	data_cartas = DataCartas.new()
	
	for i in range(data_cartas.get_size()):
		array_no_repetidos.append(i)
	


func set_cartas_elegidas(carta1 : AbstractCard, carta2 : AbstractCard):
	self.carta1 = carta1.clone()
	self.carta2 = carta2.clone()
	print("exito")

func instanciar_carta_no_repetida():
	if array_no_repetidos.size() == 0:
		print("si")
		return instanciar_carta()
	var carta = load(PATH_ESCENA_CARTA).instantiate()
	var n = rng.randi_range(0, array_no_repetidos.size() -1)
	var index = array_no_repetidos[n]
	array_no_repetidos.remove_at(n)
	carta.set_script(load(data_cartas.get_script_carta(index)))
	print(array_no_repetidos)
	return carta

func instanciar_carta():
	var carta = load(PATH_ESCENA_CARTA).instantiate()
	var n = rng.randi_range(0, data_cartas.get_size() - 1)
	carta.set_script(load(data_cartas.get_script_carta(n)))
	return carta
	
	
	
#func _ready():
#	carta1 = load(PATH_ESCENA_CARTA).instantiate()
#	carta2 = load(PATH_ESCENA_CARTA).instantiate()



func _process(delta):
	if Input.is_key_pressed(KEY_TAB):
		GlobalCartas.carta1.activar_efecto()
	elif Input.is_key_pressed(KEY_Q):
		GlobalCartas.carta2.activar_efecto()
	pass

