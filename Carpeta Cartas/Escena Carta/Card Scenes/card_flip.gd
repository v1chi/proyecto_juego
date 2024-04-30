extends Node2D
var anim

# Called when the node enters the scene tree for the first time.

func activate_card_flip():
	anim.play("card_flip")


func _ready():	
	anim = $AnimationPlayer
	anim.play("shift")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
