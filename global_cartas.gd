extends Node



const PATH_ESCENA_CARTA : String = "res://Carpeta Cartas/Escena Carta/Card Scenes/card.tscn"
var array_scripts : Array
var rng = RandomNumberGenerator.new()

var carta1 : AbstractCard 
var carta2 : AbstractCard 



func set_cartas_elegidas(carta1 : AbstractCard, carta2 : AbstractCard):
	self.carta1 = carta1.clone()
	self.carta2 = carta2.clone()
	print("exito")

func _on_card_effected(id):
	print("Eliminando el Script de la carta con ID: " + str(id))
	_remover_script(id)
	
func instanciar_carta():
	var carta = load(PATH_ESCENA_CARTA).instantiate()
	var n = rng.randi_range(0, array_scripts.size() - 1)
	carta.set_script(load(array_scripts[n]))
	
	return carta
	
func _remover_script(id : int):
	array_scripts.pop_at(array_scripts.find(id))


func _init():
	# Path de los scripts de las cartas
	array_scripts = [
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta1.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta2.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta3.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta4.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta5.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta6.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta7.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta8.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta9.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta10.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta11.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta12.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta13.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta14.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta15.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta16.gd"
	]

#func _ready():
#	carta1 = load(PATH_ESCENA_CARTA).instantiate()
#	carta2 = load(PATH_ESCENA_CARTA).instantiate()



func _process(delta):
	if Input.is_key_pressed(KEY_TAB):
		GlobalCartas.carta1.activar_efecto()
	elif Input.is_key_pressed(KEY_Q):
		GlobalCartas.carta2.activar_efecto()
	pass

