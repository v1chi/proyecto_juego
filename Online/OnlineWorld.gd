extends Node2D

@onready var contenedorCorazones = $CanvasLayer/contenedorCorazones
@onready var player = $TileMap/char1

@onready var spawn_timer = Timer.new()
@onready var gui_cartas = $CanvasLayer2/GuiCartas
@onready var label = $CanvasLayer2/Control/Label
@onready var main_timer = $CanvasLayer2/Control/Timer

var path_enviar_dato = "res://Online/EnviarDatos.tscn"
# Definimos los archivos de los diferentes enemigos
var enemy_scenes = [
	"res://Characters/Enemies/charSlime/char_slime.tscn",
	"res://Characters/Enemies/GInfected/GInfected.tscn",
]

func _connect_signal_main_timer():
	gui_cartas.connect_main_timer(main_timer)
	main_timer.timeout.connect(_on_main_timer_timeout)

func _on_main_timer_timeout():
	var escena_enviar = load(path_enviar_dato).instantiate()
	$Pausa.set_process_mode(Node.PROCESS_MODE_INHERIT)
	$CanvasLayer2.add_child(escena_enviar)
# Called when the node enters the scene tree for the first time.
func _ready():
	_connect_signal_main_timer()
	main_timer.start()
	contenedorCorazones.setMaxHearts(player.maxHealth)
	player.healthChanged.connect(contenedorCorazones.updateHearts)
	
	# Configurar el timer para el cooldown de spawn
	spawn_timer.set_wait_time(0.5)
	spawn_timer.set_autostart(true)
	spawn_timer.set_one_shot(false)
	add_child(spawn_timer)
	spawn_timer.timeout.connect(_spawn_enemy)

	# Empezar el proceso de spawn
	spawn_timer.start()
	
	# Función para spawnear enemigos
func _spawn_enemy():
	var random_enemy = enemy_scenes[randi() % enemy_scenes.size()]
	
	var instancia = load(random_enemy).instantiate()

	var spawn_position
	var random_position = randi() % 4
	if random_position == 0:
		spawn_position = $SquaresLimits.get_pos_valida_top_left()
	elif random_position == 1:
		spawn_position = $SquaresLimits.get_pos_valida_top_right()
	elif random_position == 2:
		spawn_position = $SquaresLimits.get_pos_valida_bottom_left()
	else:
		spawn_position = $SquaresLimits.get_pos_valida_bottom_right()
	
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




# Asegurarse de que el random number generator está inicializado
func _init():
	randomize()
