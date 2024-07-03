extends Control

@onready var audio = $AudioStreamPlayer

func _ready():
	GlobalCartas.reset_elegidas()
	GlobalCartas.reset_no_repetidos()
	audio.play()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
