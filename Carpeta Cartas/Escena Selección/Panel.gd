extends Control

signal descrip_changed(texto)
signal card_selected(card)

func get_description():
	assert(get_child(0) != null, "No existe la carta del panel: " + str(self.name))
	var card = get_child(0)
	return card.get_descripcion()

func disconnect_mouse_entered_exited():
	if is_connected("mouse_entered", _on_mouse_entered):
		disconnect("mouse_entered", _on_mouse_entered)

	if is_connected("mouse_exited", _on_mouse_exited):
		disconnect("mouse_exited", _on_mouse_exited)


func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		disconnect_mouse_entered_exited()
		card_selected.emit(null)



func _on_mouse_entered():
	set_position(Vector2(position.x, position.y - 4))
	set_self_modulate(Color(0, 0, 0, 1))
	descrip_changed.emit(get_description())



func _on_mouse_exited():
	set_position(Vector2(position.x , position.y + 4))
	set_self_modulate(Color(255, 255, 255, 0))

	


