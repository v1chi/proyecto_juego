extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/Q.tres"
var flag = true

func _ready():
	super._ready()
	print("Ready de la clase concreta")
	

func get_id():
	return id

func _activar_efecto_hijo():
	if !flag:
		return 
	anim.play("palpeo")
	flag = false
	var enemies = Global.get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.attack_damage = enemy.attack_damage*2
	
	

func get_icono():
	return path_carta_frontal
	
func _init(): 
	self.id = 7
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Los enemigos reciben el doble de daño"
