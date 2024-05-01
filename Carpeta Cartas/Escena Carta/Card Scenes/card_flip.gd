extends Node2D
var anim


signal card_created

# Called when the node enters the scene tree for the first time.

func activate_card_flip():
	anim.play("card_flip")
	


func on_card_created():
	print("Carta creada ")
	card_created.emit()


func _ready():	
	anim = $AnimationPlayer
	anim.play("shift")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
	
