extends Control


var is_popup = true
var anim
var carta1 : AbstractCard 
var carta2 : AbstractCard

func activate_fade_in():
	carta1.anim.play("fade_in")
	carta2.anim.play("fade_in")

func _ready():
	anim = $AnimationPlayer
	carta1 = GlobalCartas.carta1.clone()
	carta2 = GlobalCartas.carta2.clone()
	add_cartas_panel()
	carta1.visible = false
	carta2.visible = false
	
func add_cartas_panel():
	$Panel.add_child(carta1)
	$Panel2.add_child(carta2)

func _on_texture_button_pressed():
	if is_popup:
		anim.play_backwards("popup")
	else:
		anim.play("popup")
	is_popup = !is_popup
	



