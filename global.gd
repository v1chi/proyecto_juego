extends Node

var current_scene = null
var score : int = 0

signal update_score

func set_score_zero():
	score = 0
	update_score.emit()


func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass


func score_agregate(score):
	self.score += score
	update_score.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	

func goto_scene_card_to_world(path_card, path_world):
	call_deferred("_deferred_goto_scene_card_to_world", path_card, path_world)

func _deferred_goto_scene_card_to_world(path_card, path_world):
	current_scene.free()
	var s = ResourceLoader.load(path_card)
	current_scene = s.instantiate()
	current_scene.path_siguiente_piso = path_world
	get_tree().root.add_child(current_scene)
	
	if _is_world_scene():
		_setup_card_in_world()
		
	get_tree().current_scene = current_scene
	

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)

	if _is_world_scene():
		_setup_card_in_world()
		
	get_tree().current_scene = current_scene
	

func _is_world_scene():
	var array_world = get_tree().get_nodes_in_group("World")
	if array_world.size() == 0:
		return false 
	return true

func _setup_card_in_world():
	var contenedor_carta = get_tree().get_nodes_in_group("ContenedorCarta")[0]
	if(contenedor_carta != null and GlobalCartas.carta1 != null):
		contenedor_carta = contenedor_carta._setup_carta1(GlobalCartas.carta1)._setup_carta2(GlobalCartas.carta2)
		contenedor_carta.add_cartas()
	
