extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/cartas_ia/Cartas buenas/escudo.png"
var player
var damage = 2
var contenedor_corazon
var flag = true
var vida_aumentada = 3

func _activar_efecto_hijo():
	if flag:
		anim.play("palpeo")
		player = Global.get_tree().get_nodes_in_group("Player")[0]
		contenedor_corazon = Global.get_tree().get_nodes_in_group("ContenedorCorazon")[0]	
		player.maxHealth += vida_aumentada 
		player.currentHealth = player.currentHealth + vida_aumentada if player.currentHealth + vida_aumentada <= player.maxHealth else  player.maxHealth 
		contenedor_corazon.setMaxHearts(player.maxHealth)
		contenedor_corazon.updateHearts(player.currentHealth)
		flag = false
	
func desactivar_efecto():
	if player != null and contenedor_corazon != null:
		player.maxHealth -= vida_aumentada
		player.currentHealth = min(player.maxHealth, player.currentHealth)
		contenedor_corazon.setMaxHearts(player.maxHealth)
		contenedor_corazon.updateHearts(player.currentHealth)
		 
	


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
	self.descripcion_carta = "Protección de +3 de Vida"
	self.path_carta_trasera_imagen = "res://Carpeta Cartas/Escena Carta/cartas_ia/Parte Trasera Cartas/carta_trasera_buena.png"
