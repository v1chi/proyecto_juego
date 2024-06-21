extends Node2D

@onready var contenedorCorazones = $CanvasLayer/contenedorCorazones
@onready var player = $TileMap/char1

@onready var spawn_timer = Timer.new()

@onready var label = $CanvasLayer2/Control/Label
@onready var timer = $CanvasLayer2/Control/Timer

# Definimos los archivos de los diferentes enemigos
var enemy_scenes = [
	"res://Characters/Enemies/charSlime/char_slime.tscn",
	"res://Characters/Enemies/GInfected/GInfected.tscn",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
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
	var time_left = timer.time_left
	var minutes = floor(time_left / 60)
	var seconds = int(minutes) % 60
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
