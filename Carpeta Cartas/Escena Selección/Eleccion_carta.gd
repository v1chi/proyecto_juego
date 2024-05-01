extends Control

var panels = []
var scene_card = load("res://Carpeta Cartas/Escena Carta/Card Scenes/card_flip.tscn")




func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass

func add_panels():
	for panel_id in range(1, 7, 1):
		panels.append(get_node("Contenedor/Panel" + str(panel_id)))
		


func add_card_to_panel(panel_id):
	var instance_card = scene_card.instantiate()
	panels[panel_id - 1].add_child(instance_card)

func create_deck():
	for panel_id in range(1, 7, 1):
		add_card_to_panel(panel_id)
		print("Esperando")
		await wait(0.25)



# Called when the node enters the scene tree for the first time.
func _ready():
	add_panels()
	create_deck()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
