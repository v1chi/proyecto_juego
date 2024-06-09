extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/Q.tres"
var flag = true
var player
var contenedor_corazon
var enemies_defeated_count
var timer


var contador_efectos

func _ready():
	super._ready()
	print("Ready de la clase concreta")
	

func get_id():
	return id


func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass

func _activar_efecto_hijo():
	if flag:
		player = Global.get_tree().get_nodes_in_group("Player")[0]
		contenedor_corazon = Global.get_tree().get_nodes_in_group("ContenedorCorazon")[0]
		player.maxHealth = 3
		player.currentHealth = min(player.maxHealth, player.currentHealth)
		contenedor_corazon.setMaxHearts(player.maxHealth)
		contenedor_corazon.updateHearts(player.currentHealth)
		flag = false
	
	

func get_icono():
	return path_carta_frontal
	
func _init():
	self.contador_efectos = 0
	self.id = 10
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Vida reducida"
