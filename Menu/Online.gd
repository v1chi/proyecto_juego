extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

var cambio = "res://Online/OnlineWorld.tscn"

func _on_pressed():
	Global.goto_scene(cambio)
	pass # Replace with function body.
