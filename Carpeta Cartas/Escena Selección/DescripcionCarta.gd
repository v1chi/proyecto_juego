extends Label



func set_descripcion():
	print("Cambia la descripcion")
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.



func _on_panel_descrip_changed(texto):
	set_text(texto)
