extends Control


@onready var animacion = $AnimationPlayer
@onready var tiempo = $Timer
func _ready():
	animacion.play("new_animation")
	tiempo.start()
	tiempo.callable("timeout", self, "_on_timer_timeout")


var cambioEscena = "res://Scene/world.tscn"

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scene/world.tscn")
	pass # Replace with function body.
