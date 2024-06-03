extends Control


var is_popup = false
var anim

func _ready():
	visible = false
	anim = $AnimationPlayer

func _on_texture_button_pressed():
	visible = true
	if is_popup:
		anim.play_backwards("popup")
	else:
		anim.play("popup")
	is_popup = !is_popup
	
