extends Control

var anim : AnimationPlayer
var path_siguiente_piso : String = "res://Scene/world.tscn"

func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	assert(get_node("AnimationScene") != null, "Animation Scene es nulo ")
	assert(get_node("EleccionCarta") != null, "Eleccion carta es nulo")
	anim = get_node("AnimationScene")

func _on_eleccion_carta_selection_finished(cartas):
	GlobalCartas.set_cartas_elegidas(cartas[0], cartas[1])
	await wait(1)
	Global.goto_scene(path_siguiente_piso)


func set_path_siguiente_piso(path : String):
	path_siguiente_piso = path

func get_path_siguiente_piso():
	return path_siguiente_piso

func _on_button_pressed():
	Global.goto_scene(path_siguiente_piso)
	
	
