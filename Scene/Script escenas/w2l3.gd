extends Node2D
@onready var contenedorCorazones = $CanvasLayer/contenedorCorazones
@onready var player = $TileMap/char1
@onready var musica = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	musica.play()
	contenedorCorazones.setMaxHearts(player.maxHealth)
	player.healthChanged.connect(contenedorCorazones.updateHearts)



func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass


#Probando el funcionamiento de los limites de posicion
"""
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
