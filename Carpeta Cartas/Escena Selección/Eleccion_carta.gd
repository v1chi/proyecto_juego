class_name Eleccion_carta
extends Control

 
signal selection_finished(cartas)


var panels = []
var controlador_cartas = preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/CardManager.gd").new()


var count_selected_card = 0
var lista_cartas_seleccionadas = []

func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass

func add_panels():
	for panel_id in range(1, 7, 1):
		panels.append(get_node("Contenedor/Panel" + str(panel_id)))
	
func add_card_to_panel(panel_id):
	var instance_card = controlador_cartas.instantiate_card()
	panels[panel_id - 1].add_child(instance_card)
	panels[panel_id - 1].card_created.emit(instance_card)

func create_deck():
	for panel_id in range(1, 7, 1):
		add_card_to_panel(panel_id)
		await wait(0.25)


func add_cart_to_selected(card: AbstractCard):
	assert(count_selected_card <= 2, "Se excedio el límite de cartas seleccionables")
	lista_cartas_seleccionadas.append(card)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_panels()
	create_deck()


func _on_panel_card_selected(card):
	count_selected_card += 1
	add_cart_to_selected(card)
	if count_selected_card >= 2:
		await wait(0.25)
		selection_finished.emit(lista_cartas_seleccionadas)
		disconnect("card_selected", _on_panel_card_selected)



func _on_selection_finished(cartas):
	for panel in panels:
		panel.disconnect_mouse_entered_exited()
		if not(panel.get_card() in lista_cartas_seleccionadas):
			panel.get_card().activate_discard_card()
	
	
	
	
