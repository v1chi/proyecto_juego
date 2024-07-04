extends Node2D

@onready var contenedorCorazones = $CanvasLayer/contenedorCorazones
@onready var player = $TileMap/char1

@onready var spawn_timer : Timer
@onready var gui_cartas = $CanvasLayer2/GuiCartas
@onready var label = $CanvasLayer2/Control/Label
@onready var main_timer = $CanvasLayer2/Control/Timer
var controlador_spawn = ControladorSpawn.new()
@onready var musica = $AudioStreamPlayer

var path_enviar_dato = "res://Online/EnviarDatos.tscn"
# Definimos los archivos de los diferentes enemigos


func _connect_signal_main_timer():
	gui_cartas.connect_main_timer(main_timer)
	main_timer.timeout.connect(_on_main_timer_timeout)

func _on_main_timer_timeout():
	var escena_enviar = load(path_enviar_dato).instantiate()
	$Pausa.set_process_mode(Node.PROCESS_MODE_INHERIT)
	$CanvasLayer2.add_child(escena_enviar)

func _on_death_player():
	main_timer.stop()
	main_timer.emit_signal("timeout")

# Called when the node enters the scene tree for the first time.
func _ready():
	player.is_mode_online = true
	player.death.connect(_on_death_player)
	musica.play()
	_connect_signal_main_timer()
	main_timer.start()
	player.set_maxHealth(10)
	player.currentHealth = player.maxHealth
	contenedorCorazones.setMaxHearts(player.maxHealth)
	player.healthChanged.connect(contenedorCorazones.updateHearts)
	
	gui_cartas.get_node("Timer").timeout.connect(_on_timeout_cartas)
	
	
	spawn_timer = _get_spawn_timer()
	add_child(spawn_timer)
	spawn_timer.timeout.connect(_spawn_enemy)
	spawn_timer.start()



var path_pocion = "res://Carpeta Corazones/pocion.tscn"
func _spawn_pocion():
	var pocion = load(path_pocion).instantiate()
	var spawn_position = $SquaresLimits.get_pos_valida_azar()
	pocion.position = spawn_position
	$TileMap.add_child(pocion)
	

func _spawn_enemy():
	var instancia = controlador_spawn.instanciar_enemigo(ronda)
	var spawn_position = $SquaresLimits.get_pos_valida_azar()
	instancia.position = spawn_position
	$TileMap.add_child(instancia)
	_generar_particula(instancia)

func time_left_alive():
	var time_left = main_timer.time_left
	var minutes = int(time_left / 60)
	var seconds = int(abs(minutes*60 - time_left))
	return [minutes, seconds]

func _process(delta):
	label.text = "%02d:%02d" % time_left_alive()

var particula = load("res://Carpeta Cartas/Escena Carta/Assets/Effect and Bullet 16x16 (1)/efecto_entrada.tscn")
func _generar_particula(instancia):
	var par = particula.instantiate()
	instancia.add_child(par)
	instancia.get_node("AnimationPlayer").play("aparecer")
	par.set_emitting(true)
	instancia.desactivar_fisicas(1)


func _disconnect_spawn_timer():
	if spawn_timer != null and spawn_timer.timeout.is_connected(_spawn_enemy):
		spawn_timer.timeout.disconnect(_spawn_enemy)
func _set_spawn_timer_null():
	if spawn_timer == null:
		pass
	else:
		spawn_timer.queue_free()
		spawn_timer = null

const INIT_SPAWN_WAIT_TIME = 4
func _get_spawn_wait_time():
	print(max(1.5, INIT_SPAWN_WAIT_TIME - 0.4 * ronda))
	return max(1.5, INIT_SPAWN_WAIT_TIME - 0.4 * ronda)

func _get_spawn_timer():
	var timer = Timer.new()
	timer.set_wait_time(_get_spawn_wait_time())
	timer.set_autostart(true)
	timer.set_one_shot(false)
	return timer


var ronda : int = 0
func _on_timeout_cartas():
	ronda += 1
	_disconnect_spawn_timer()
	_set_spawn_timer_null()
	spawn_timer = _get_spawn_timer()
	add_child(spawn_timer)
	spawn_timer.timeout.connect(_spawn_enemy)
	spawn_timer.start()
	
	



# Asegurarse de que el random number generator está inicializado
func _init():
	randomize()
