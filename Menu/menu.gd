extends Control

@onready var audio = $AudioStreamPlayer

func _ready():
	audio.play()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
