extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/cartas_ia/Cartas malas/vision--.png"
var player
var enemies_defeated_count
var timer
var escena_reducida = "res://Carpeta Cartas/vision_reducida.tscn"
var flag = true
var contador_efectos
var instancia_vision

func _ready():
	super._ready()
	super.set_scale_carta_frontal(Vector2(0.17,0.17))
	super.set_scale_carta_trasera(Vector2(0.26,0.26))

func get_id():
	return id


func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass

func _activar_efecto_hijo():
	if flag:
		anim.play("palpeo")
		player = Global.get_tree().get_nodes_in_group("Player")[0]
		instancia_vision = load(escena_reducida).instantiate()
		player.add_child(instancia_vision)
	flag = false

func desactivar_efecto():
	instancia_vision.get_node("AnimationPlayer").play_backwards("ready")
	await Global.wait(0.5)
	player.remove_child(instancia_vision)
	instancia_vision.queue_free()
	print("sdljknds")


func get_icono():
	return path_carta_frontal
	
func _init():
	self.contador_efectos = 0
	self.id = 11
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Visión reducida"
	self.path_carta_trasera_imagen = "res://Carpeta Cartas/Escena Carta/cartas_ia/Parte Trasera Cartas/parte trasera mala.png"
