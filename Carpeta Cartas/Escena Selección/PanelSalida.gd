extends TextureRect


func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
