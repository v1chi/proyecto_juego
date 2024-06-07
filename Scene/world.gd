extends Node2D
@onready var contenedorCorazones = $CanvasLayer/contenedorCorazones
@onready var player = $TileMap/char1
@onready var musica = $MusicaFondo

# Called when the node enters the scene tree for the first time.
func _ready():
	musica.play()
	contenedorCorazones.setMaxHearts(player.maxHealth)
	contenedorCorazones.updateHearts(player.currentHealth)
	player.healthChanged.connect(contenedorCorazones.updateHearts)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
