extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if get_rect().has_point(event.global_position):
			print("Click")



func _on_mouse_entered():
	print("AAAAAA")
	set_position(Vector2(position.x, position.y - 4))
	set_self_modulate(Color(0, 0, 0, 1))



func _on_mouse_exited():
	set_position(Vector2(position.x , position.y + 4))
	set_self_modulate(Color(255, 255, 255, 0))

