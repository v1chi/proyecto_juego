extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/Q.tres"
var enemy 

func _ready():
	super._ready()
	print("Ready de la clase concreta")
	

func get_id():
	return id

func _activar_efecto_hijo():
	var enemies = Global.get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.speed = enemy.speed * 1.25 
	

func get_icono():
	return path_carta_frontal
	
func _init(): 
	self.id = 6
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "La velocidad de los enemigos aumentan en un 25%"
