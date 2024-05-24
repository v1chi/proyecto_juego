extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/Q.tres"
var enemy 

func _ready():
	super._ready()
	print("Ready de la clase concreta")
	

func get_id():
	return id

func _activar_efecto_hijo():
	enemy = get_node("/root/world2/TileMap/enemigo1")
	enemy.speed = 33
	

func _init(): 
	self.id = 6
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Carta 6"
