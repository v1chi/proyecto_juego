extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/cartas_ia/Cartas buenas/escudo.png"
var player
var damage = 2

func _activar_efecto_hijo():
	anim.play("palpeo")
	player = Global.get_tree().get_nodes_in_group("Player")[0]
	player.currentHealth -= damage 
	damage = 0
	player.healthChanged.emit(player.currentHealth)
	

func desactivar_efecto():
	pass




func get_icono():
	return path_carta_frontal

func get_id():
	return id

func _ready():
	super._ready()
	super.set_scale_carta_frontal(Vector2(0.134,0.134))
	super.set_scale_carta_trasera(Vector2(0.21,0.21))
	print("Ready de la clase concreta")
	


func _init(): 
	self.id = 2
	self.imagen_carta = load(path_carta_frontal)
	#falta cambiar la descripcion de la carta "Te aplicas un escudo"
	self.descripcion_carta = "Empiezas con -2 de vida al iniciar la mazmorra"
	self.path_carta_trasera_imagen = "res://Carpeta Cartas/Escena Carta/cartas_ia/Parte Trasera Cartas/carta_trasera_buena.png"
