extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/3.tres"
var player
var damage = 2

func _activar_efecto_hijo():
	player = get_node("/root/world2/TileMap/char1")
	player.currentHealth -= damage 
	damage = 0
	player.healthChanged.emit(player.currentHealth)
	

func get_icono():
	return path_carta_frontal

func get_id():
	return id

func _ready():
	super._ready()
	print("Ready de la clase concreta")
	


func _init(): 
	self.id = 2
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Carta 2"
