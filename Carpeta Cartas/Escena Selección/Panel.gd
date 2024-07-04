extends Control


var card
var anim : AnimationPlayer
var text 
signal card_created(card: AbstractCard)
signal descrip_changed(texto)
signal card_selected(card: AbstractCard)


func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass


func set_card(card1 : AbstractCard):
	self.card = card1
	

func get_card():
	return card

func descartar_carta():
	card.activate_discard_card()

func get_description():
	return card.get_descripcion()


func connect_mouse_event():
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	connect("gui_input", _on_gui_input)

func disconnect_mouse_entered_exited():
	if is_connected("mouse_entered", _on_mouse_entered):
		disconnect("mouse_entered", _on_mouse_entered)
		
	if is_connected("mouse_exited", _on_mouse_exited):
		disconnect("mouse_exited", _on_mouse_exited)
		
	if is_connected("gui_input", _on_gui_input):
		disconnect("gui_input", _on_gui_input)
		


func _show_description(name_panel):
	anim.play(name_panel+"_show")


func _hide_description(name_panel):
	anim.play_backwards(name_panel + "_show")
	
	


func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		disconnect_mouse_entered_exited()
		card_selected.emit(card)



func _on_mouse_entered():
	disconnect("mouse_exited", _on_mouse_exited)
	set_position(Vector2(position.x, position.y - 4))
	set_self_modulate(Color(0, 0, 0, 1))
	_show_description(name)
	#descrip_changed.emit(get_description())
	text.set_text("[center]" + get_description() + "[/center]")
	connect("mouse_exited", _on_mouse_exited)



func _on_mouse_exited():
	set_position(Vector2(position.x , position.y + 4))
	set_self_modulate(Color(255, 255, 255, 0))
	_hide_description(name)

func _on_card_created(card):
	connect_mouse_event()
	set_card(card)



func _ready():
	anim = $RichTextLabel/AnimationPlayer
	text = $RichTextLabel
	
