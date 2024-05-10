extends Button


var scene = preload("res://Scene/world.tscn").instantiate()



# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	get_tree().root.add_child(scene)
	get_tree().root.get_child(0).set_visible(false)
	pass # Replace with function body.
