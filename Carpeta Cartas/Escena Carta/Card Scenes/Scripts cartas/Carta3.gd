extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/cartas_ia/Cartas malas/menor velocidad Player.png"
var player 

func _ready():
	super._ready()
	super.set_scale_carta_frontal(Vector2(0.15,0.165))
	super.set_scale_carta_trasera(Vector2(0.26,0.26))
	print("Ready de la clase concreta")
	


func get_icono():
	return path_carta_frontal
	
func get_id():
	return id

func _activar_efecto_hijo():
	anim.play("palpeo")
	player = Global.get_tree().get_nodes_in_group("Player")[0]
	player.speed = 30
	

func _init(): 
	self.id = 3
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Disminuye tu velocidad de MOV"
	self.path_carta_trasera_imagen = "res://Carpeta Cartas/Escena Carta/cartas_ia/Parte Trasera Cartas/parte trasera mala.png"
