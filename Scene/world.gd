extends Node2D
@onready var contenedorCorazones = $CanvasLayer/contenedorCorazones
@onready var player = $TileMap/char1

@onready var spawn_timer = Timer.new()
var spawn_range = 90  # Puedes ajustar este valor según lo necesites

# Dimensiones del TileMap
@onready var tilemap = $TileMap
var tile_size = 32  # Ajusta según el tamaño de tus tiles
var map_width = 10  # Ajusta según el número de tiles en el eje x
var map_height = 10 # Ajusta según el número de tiles en el eje y

# Rango de spawn dentro del TileMap
var spawn_margin = 1  # Margin de tiles desde el borde del TileMap

# Definimos los archivos de los diferentes enemigos
var enemy_scenes = [
	"res://Characters/Enemies/charSlime/char_slime.tscn",
	"res://Characters/Enemies/GInfected/GInfected.tscn",
]

# Called when the node enters the scene tree for the first time.
func _ready():
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
		spawn_position = $SquaresLimits/TopLeft.position
	elif random_position == 1:
		spawn_position = $SquaresLimits/TopRight.position
	elif random_position == 2:
		spawn_position = $SquaresLimits/BottomLeft.position
	else:
		spawn_position = $SquaresLimits/BottomRight.position
	
	# Añadir aleatoriedad a la posición de spawn
	spawn_position += Vector2(randf_range(-(spawn_range), spawn_range), randf_range(-spawn_range, spawn_range))

	instancia.position = spawn_position
	$TileMap.add_child(instancia)

# Asegurarse de que el random number generator está inicializado
func _init():
	randomize()
"""
func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass


#Probando el funcionamiento de los limites de posicio
var file_slime = "res://Characters/Enemies/charSlime/char_slime.tscn"

func _process(delta):
	set_process(false)
	await wait(2)
	for i in range(4):
		var lugar
		if i == 0:
			lugar = $SquaresLimits.get_pos_valida_top_left()
		elif i == 1:
			lugar = $SquaresLimits.get_pos_valida_top_right()
		elif i == 2:
			lugar = $SquaresLimits.get_pos_valida_bottom_left()
		else:
			lugar = $SquaresLimits.get_pos_valida_bottom_right()
		var instancia = load(file_slime).instantiate()
		instancia.position =lugar
		$TileMap.add_child(instancia)
	set_process(true)
"""
