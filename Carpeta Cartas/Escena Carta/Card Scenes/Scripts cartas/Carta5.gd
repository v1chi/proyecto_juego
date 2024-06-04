extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/JOKER_ROJO.tres"
var player 

func _ready():
	super._ready()
	print("Ready de la clase concreta")
	

func get_id():
	return id

func _activar_efecto_hijo():
	player = get_node("/root/world2/TileMap/char1")
	player.custom_speed = 0.65
	

func get_icono():
	return path_carta_frontal
	
func _init(): 
	self.id = 5
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Nerf VEL"
