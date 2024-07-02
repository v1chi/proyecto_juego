extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/cartas_ia/Cartas malas/Inflinges menos daño.png"
var player
var enemies_defeated_count
var timer
var escena_reducida = "res://Carpeta Cartas/vision_reducida.tscn"
var flag = true
var contador_efectos

func _ready():
	super._ready()
	super.set_scale_carta_frontal(Vector2(0.137,0.139))
	super.set_scale_carta_trasera(Vector2(0.26,0.26))
	print("Ready de la clase concreta")
	

func get_id():
	return id


func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass

func _activar_efecto_hijo():
	if !flag:
		return 
	flag = false
	anim.play("palpeo")
	var enemies = Global.get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.attack_damage = enemy.attack_damage/2




func get_icono():
	return path_carta_frontal
	
func _init():
	self.contador_efectos = 0
	self.id = 12
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Reducción de daño a los enemigos"
	self.path_carta_trasera_imagen = "res://Carpeta Cartas/Escena Carta/cartas_ia/Parte Trasera Cartas/parte trasera mala.png"
