extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/4.tres"
var player 

func _ready():
	super._ready()
	print("Ready de la clase concreta")
	


func get_icono():
	return path_carta_frontal
	
func get_id():
	return id

func _activar_efecto_hijo():
	player = Global.get_tree().get_nodes_in_group("Player")[0]
	player.speed = 30
	

func _init(): 
	self.id = 3
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Disminuye tu velocidad de MOV"
