extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/cartas_ia/Cartas malas/Enemigos veloces.png"
var enemy 

func _ready():
	super._ready()
	super.set_scale_carta_frontal(Vector2(0.127,0.127))
	super.set_scale_carta_trasera(Vector2(0.26,0.26))
	print("Ready de la clase concreta")
	

func get_id():
	return id

func _activar_efecto_hijo():
	anim.play("palpeo")
	var enemies = Global.get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.speed = 25 
	

func get_icono():
	return path_carta_frontal
	
func _init(): 
	self.id = 6
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "La velocidad de los enemigos aumentan en un 25%"
	self.path_carta_trasera_imagen = "res://Carpeta Cartas/Escena Carta/cartas_ia/Parte Trasera Cartas/parte trasera mala.png"
