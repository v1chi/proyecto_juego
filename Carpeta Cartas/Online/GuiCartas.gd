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
	parent_carta1.remove_child(carta1)
	parent_carta2.remove_child(carta2)
	pass 

func _fade_in_cartas():
	var carta1 = GlobalCartas.instanciar_carta_no_repetida()
	var carta2 = GlobalCartas.instanciar_carta()
	parent_carta1.add_child(carta1)
	parent_carta2.add_child(carta2)
	carta1.anim.play("fade_in")
	carta2.anim.play("fade_in")
	pass


func _on_timer_timeout():
	_fade_out_cartas()
	$AnimationPlayer.play("aviso_entrada")
	await wait(2)
	_fade_in_cartas()
	await wait(3)
	$AnimationPlayer.play_backwards("aviso_entrada")
	

	
