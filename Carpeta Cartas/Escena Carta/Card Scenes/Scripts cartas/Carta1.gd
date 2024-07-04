extends AbstractCard

# Carta qie afecta la velocidad del jugador
var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/cartas_ia/Cartas buenas/Lentitud enemiga.png"
var player


func _activar_efecto_hijo():
	anim.play("palpeo")
	FactoryEnemy.agregar_efecto("_on_active_carta1")
	var enemies = Global.get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if enemy != null:
			enemy.speed -= 10
			enemy.patrol_speed -= 6
			enemy.custom_speed_animation = 0.5
			
			


func desactivar_efecto():
	var enemies = Global.get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if enemy != null:
			enemy.speed += 10
			enemy.patrol_speed += 5
			enemy.custom_speed_animation = 1
	

	
func get_id():
	return id


func get_icono():
	return path_carta_frontal

func _ready():
	super._ready()
	super.set_scale_carta_frontal(Vector2(0.243,0.266))
	super.set_scale_carta_trasera(Vector2(0.21,0.21))
	print("Ready de la clase concreta")
	


func _init(): 
	self.id = 1
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Disminución de velocidad a los enemigos"
	self.path_carta_trasera_imagen = "res://Carpeta Cartas/Escena Carta/cartas_ia/Parte Trasera Cartas/carta_trasera_buena.png"
