extends Control

var anim : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim = $AnimationPlayer
	anim.play("fade_in")
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_button_pressed():
	anim.play("fade_out")
