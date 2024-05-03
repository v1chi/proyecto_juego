extends Control

signal selection_finished


var panels = []
var controlador_cartas = preload("res://CardManager.gd").new()
var count_selected_card = 0

func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass

func add_panels():
	for panel_id in range(1, 7, 1):
		panels.append(get_node("Contenedor/Panel" + str(panel_id)))
	
func add_card_to_panel(panel_id):
	var instance_card = controlador_cartas.instantiate_card()
	panels[panel_id - 1].add_child(instance_card)

func create_deck():
	for panel_id in range(1, 7, 1):
		add_card_to_panel(panel_id)
		await wait(0.25)


# Called when the node enters the scene tree for the first time.
func _ready():
	add_panels()
	create_deck()


func _on_panel_card_selected(card):
	
	if count_selected_card < 1:
		count_selected_card += 1
		print("Se escogio una carta: " + str(count_selected_card))
	else:
		selection_finished.emit()
	


func _on_selection_finished():
	for panel in panels:
		panel.disconnect_mouse_entered_exited()
	
	
	
	
