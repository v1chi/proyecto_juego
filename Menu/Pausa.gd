extends CanvasLayer

@onready var pop = $AudioStreamPlayer

func _physics_process(delta):
	if Input.is_action_just_pressed("Pausa"):
		get_tree().paused = not get_tree().paused
		pop.play()
		$ColorRect.visible = not $ColorRect.visible
		$VBoxContainer/Continuar.visible = not $VBoxContainer/Continuar.visible
		$VBoxContainer/SalidaMenu.visible = not $VBoxContainer/SalidaMenu.visible
		$Label.visible = not $Label.visible

var cambioSalida = load("res://Menu/menu.tscn")

func _on_salida_menu_pressed():
	get_tree().change_scene_to_packed(cambioSalida)
	
	



func _on_continuar_pressed():
	get_tree().paused = not get_tree().paused
	$ColorRect.visible = not $ColorRect.visible
	$VBoxContainer/Continuar.visible = not $VBoxContainer/Continuar.visible
	$VBoxContainer/SalidaMenu.visible = not $VBoxContainer/SalidaMenu.visible
	$Label.visible = not $Label.visible

