extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/cartas_ia/Cartas buenas/Ataque rapido.png"
var player 

func _ready():
	super._ready()
	super.set_scale_carta_frontal(Vector2(0.465,0.51))
	super.set_scale_carta_trasera(Vector2(0.21,0.21))
	print("Ready de la clase concreta")
	

func get_id():
	return id

func _activar_efecto_hijo():
	anim.play("palpeo")
	player = Global.get_tree().get_nodes_in_group("Player")[0]
	player.custom_speed = 2

func desactivar_efecto():
	player.custom_speed = 1

func get_icono():
	return path_carta_frontal
	
func _init(): 
	self.id = 4
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Atacas el doble de rápido"
	self.path_carta_trasera_imagen = "res://Carpeta Cartas/Escena Carta/cartas_ia/Parte Trasera Cartas/carta_trasera_buena.png"
