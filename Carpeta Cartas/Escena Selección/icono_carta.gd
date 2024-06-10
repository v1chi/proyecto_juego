extends HBoxContainer



var carta1
var carta2

var parent_carta1
var parent_carta2

func add_cartas():
	
	parent_carta1.add_child(carta1)
	parent_carta2.add_child(carta2)
	
	carta1.anim.play("no_activa")
	carta2.anim.play("no_activa")

	
	pass

func _setup_carta1(carta1):
	self.carta1 = carta1
	return self
	
func _setup_carta2(carta2):
	self.carta2 = carta2
	return self

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_carta1 = get_node("ParentCard1")
	parent_carta2 = get_node("ParentCard2")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
