extends Node



const PATH_ESCENA_CARTA : String = "res://Carpeta Cartas/Escena Carta/Card Scenes/card.tscn"
var rng = RandomNumberGenerator.new()

var carta1 : AbstractCard 
var carta2 : AbstractCard 
var data_cartas : DataCartas
var array_no_repetidos : Array = []
var array_elegidas : Array = []



func _ready():
	data_cartas = DataCartas.new()
	reset_no_repetidos()
	
func reset_no_repetidos():
	array_no_repetidos = []
	for i in range(data_cartas.get_size()):
		array_no_repetidos.append(i)
		
func reset_elegidas():
	array_elegidas = []

func set_cartas_elegidas(carta1_ : AbstractCard, carta2_ : AbstractCard):
	self.carta1 = carta1_.clone()
	self.carta2 = carta2_.clone()
	agregar_cartas_elegidas(self.carta1.get_id(), self.carta2.get_id())
	

func instanciar_carta_no_repetida():
	print(array_elegidas)
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
	
func agregar_cartas_elegidas(id1, id2):
	array_elegidas.append(self.carta1.get_id() - 1)
	array_elegidas.append(self.carta2.get_id() - 1)
	reset_no_repetidos()
	for i in array_elegidas:
		array_no_repetidos.erase(i)
	
