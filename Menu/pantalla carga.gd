extends Control


@onready var animacion = $AnimationPlayer
@onready var tiempo = $Timer
func _ready():
	animacion.play("new_animation")
	tiempo.start()



var cambioEscena = "res://Scene/world.tscn"

func _on_timer_timeout():
	Global.goto_scene(cambioEscena)
	pass # Replace with function body.
