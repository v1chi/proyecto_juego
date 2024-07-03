extends Control


var parent_carta1 : Node2D
var parent_carta2 : Node2D


func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	parent_carta1 = $ParentCarta1
	parent_carta2 = $ParentCarta2
	pass # Replace with function body.


func estan_cartas_nulas():
	return (len(parent_carta1.get_children()) == 0 or len(parent_carta2.get_children()) == 0)

func _fade_out_cartas():
	if estan_cartas_nulas():
		return 
	var carta1 = parent_carta1.get_child(0)
	var carta2 = parent_carta2.get_child(0)
	carta1.anim.play("fade_out")
	carta2.anim.play("fade_out")
	await carta1.anim.animation_finished
	await carta2.anim.animation_finished
	_eliminar_hijos(parent_carta1)
	_eliminar_hijos(parent_carta2)
	pass 

func _eliminar_hijos(parent):
	for n in parent.get_children():
		parent.remove_child(n)
		n.queue_free()


func _fade_in_cartas():
	var carta1 = GlobalCartas.instanciar_carta_no_repetida()
	var carta2 = GlobalCartas.instanciar_carta_no_repetida()
	GlobalCartas.reset_no_repetidos()
	parent_carta1.add_child(carta1)
	parent_carta2.add_child(carta2)
	carta1.anim.play("fade_in")
	carta2.anim.play("fade_in")
	pass


func _on_timer_timeout():
	_fade_out_cartas()
	FactoryEnemy.reset_efectos()
	_desactivar_cartas()
	$AnimationPlayer.play("aviso_entrada")
	await wait(3)
	_fade_in_cartas()
	await wait(1)
	_activar_cartas()
	$AnimationPlayer.play_backwards("aviso_entrada")
	
func connect_main_timer(main_timer):
	main_timer.timeout.connect(_on_main_timer_timeout)

func _on_main_timer_timeout():
	$Timer.timeout.disconnect(_on_timer_timeout)
	

func _desactivar_cartas():
	if parent_carta1.get_child_count() == 0 or parent_carta2.get_child_count() == 0:
		return
	print("Desconectando")
	parent_carta1.get_child(0).desactivar_efecto()
	parent_carta2.get_child(0).desactivar_efecto()

func _activar_cartas():
	parent_carta1.get_child(0).anim.play("no_activa")
	parent_carta2.get_child(0).anim.play("no_activa")
	parent_carta1.get_child(0).activar_efecto()
	parent_carta2.get_child(0).activar_efecto()
	
