extends Control


var anim
var eleccion_carta : Eleccion_carta
var path_siguiente_piso : String
var scene_path = "res://Scene/world.tscn"

var cartas_seleccionadas

func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	assert(get_node("AnimationScene") != null, "Animation Scene es nulo ")
	assert(get_node("EleccionCarta") != null, "Eleccion carta es nulo")
	
	eleccion_carta = get_node("EleccionCarta")
	anim = get_node("AnimationScene")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_key_pressed(KEY_TAB):
		cartas_seleccionadas[0].activar_efecto()
	elif Input.is_key_pressed(KEY_Q):
		cartas_seleccionadas[1].activar_efecto()
	pass


func _on_eleccion_carta_selection_finished(cartas):
	cartas_seleccionadas = cartas
	GlobalCartas.set_carta(load(cartas[1].get_path_script()))
	GlobalCartas.set_carta(load(cartas[0].get_path_script()))
	await wait(0.5)
	get_node("EleccionCarta").set_visible(false)
	get_node("PanelSalida").set_visible(true)
	
	pass




func _init(siguiente_piso = ''):
	path_siguiente_piso = siguiente_piso

var contenedor_carta
var scene = "res://Scene/world.tscn"
func _on_button_pressed():
	Global.goto_scene(scene)
