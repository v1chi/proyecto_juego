extends Control


var anim
var eleccion_carta : Eleccion_carta
var path_siguiente_piso : String

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
		print(cartas_seleccionadas[0].activar_efecto())
	elif Input.is_key_pressed(KEY_Q):
		print(cartas_seleccionadas[1].activar_efecto())
	pass


func _on_eleccion_carta_selection_finished(cartas):
	cartas_seleccionadas = cartas
	await wait(0.5)
	get_node("EleccionCarta").set_visible(false)
	get_node("PanelSalida").set_visible(true)
	
	pass




func _init(siguiente_piso = ''):
	path_siguiente_piso = siguiente_piso
