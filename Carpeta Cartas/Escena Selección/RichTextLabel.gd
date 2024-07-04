extends RichTextLabel



var alpha = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y >= 35 and alpha <= 1:
		alpha += 4 * delta
		set_self_modulate(Color(1,1,1,alpha))
	elif position.y < 35:
		alpha = 0
		set_self_modulate(Color(1,1,1,alpha))
	
		
	pass
