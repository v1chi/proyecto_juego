extends Control



var anim
var eleccion_carta : Eleccion_carta





# Called when the node enters the scene tree for the first time.
func _ready():
	assert(get_node("AnimationScene") != null, "Animation Scene es nulo ")
	assert(get_node("EleccionCarta") != null, "Eleccion carta es nulo")
	
	eleccion_carta = get_node("EleccionCarta")
	anim = get_node("AnimationScene")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_eleccion_carta_selection_finished():
	get_node("Panel").set_visible(true)
	pass
	
