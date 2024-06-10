extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/Q.tres"
var player
var enemies_defeated_count
var timer
var escena_reducida = "res://Carpeta Cartas/vision_reducida.tscn"
var flag = true
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
		anim.play("palpeo")
		player = Global.get_tree().get_nodes_in_group("Player")[0]
		player.add_child(load(escena_reducida).instantiate())
	flag = false




func get_icono():
	return path_carta_frontal
	
func _init():
	self.contador_efectos = 0
	self.id = 11
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Visión reducida"
