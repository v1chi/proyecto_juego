extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/cartas_ia/Cartas malas/Inmovilizacion.png"
var player
var enemies_defeated_count
var timer
var escena_reducida = "res://Carpeta Cartas/vision_reducida.tscn"
var flag = true
var contador_efectos
var idle_timer : Timer

func _ready():
	super._ready()
	super.set_scale_carta_frontal(Vector2(0.42,0.48))
	super.set_scale_carta_trasera(Vector2(0.26,0.26))
	print("Ready de la clase concreta")
	

func get_id():
	return id


func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass


func _activar_efecto_hijo():
	if not(flag):
		return
	flag = false
	player = Global.get_tree().get_nodes_in_group("Player")[0]
	idle_timer = player.get_node("IdleTimer")
	if not(idle_timer.timeout.is_connected(_on_idle_timeout)):
		idle_timer.timeout.connect(_on_idle_timeout)

func desactivar_efecto():
	set_process(false)
	if idle_timer != null and idle_timer.timeout.is_connected(_on_idle_timeout):
		idle_timer.timeout.disconnect(_on_idle_timeout)




func _process(delta):
	if idle_timer != null and not(idle_timer.is_stopped()):
		anim.play("palpeo")
	elif not(flag):
		anim.play("no_activa")
	await anim.animation_finished
	


func _on_idle_timeout():
	if player.currentHealth < player.maxHealth:
		player.currentHealth += 1
		player.healthChanged.emit(player.currentHealth)
	
	pass






func get_icono():
	return path_carta_frontal
	
func _init():
	self.enemies_defeated_count = 0
	self.contador_efectos = 0
	self.id = 15
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Recuperas vida cuando te quedas quieto"
	self.path_carta_trasera_imagen = "res://Carpeta Cartas/Escena Carta/cartas_ia/Parte Trasera Cartas/parte trasera mala.png"
