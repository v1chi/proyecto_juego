extends AbstractCard

# Carta qie afecta la velocidad del jugador




var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/2.tres"
var player


func _activar_efecto_hijo():
	player = get_node("/root/world2/TileMap/char1")
	player.speed = 100
	
	
func get_id():
	return id


func get_icono():
	return path_carta_frontal

func _ready():
	super._ready()
	print("Ready de la clase concreta")
	


func _init(): 
	self.id = 1
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Carta 1"
