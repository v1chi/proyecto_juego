extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/cartas_ia/Cartas buenas/Amplificador de daño.png"
var flag = true

func _ready():
	super._ready()
	super.set_scale_carta_frontal(Vector2(0.17,0.185))
	super.set_scale_carta_trasera(Vector2(0.21,0.21))
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
	self.path_carta_trasera_imagen = "res://Carpeta Cartas/Escena Carta/cartas_ia/Parte Trasera Cartas/carta_trasera_buena.png"
