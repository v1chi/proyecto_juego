extends CanvasLayer

@onready var pop = $AudioStreamPlayer
var cambioSalida = load("res://Menu/menu.tscn")

func _ready():
	$VBoxContainer/Continuar.connect("pressed", Callable(self, "_on_continuar_pressed"))
	$VBoxContainer/SalidaMenu.connect("pressed", Callable(self, "_on_salida_menu_pressed"))

func _physics_process(delta):
	if Input.is_action_just_pressed("Pausa"):
		_toggle_pause()

func _toggle_pause():
	get_tree().paused = not get_tree().paused
	pop.play()
	$ColorRect.visible = not $ColorRect.visible
	$VBoxContainer/Continuar.visible = not $VBoxContainer/Continuar.visible
	$VBoxContainer/SalidaMenu.visible = not $VBoxContainer/SalidaMenu.visible
	$Label.visible = not $Label.visible

func _on_salida_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(cambioSalida)

func _on_continuar_pressed():
	_toggle_pause()
