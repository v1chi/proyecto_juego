extends HBoxContainer
@onready var ClaseInterfazCorazon = preload("res://Carpeta Corazones/Escena corazones/corazon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("ContenedorCorazon")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setMaxHearts(max: int):
	remove_children()
	for i in range(max):
		var heart = ClaseInterfazCorazon.instantiate()
		add_child(heart)

func updateHearts(currentHealth: int):
	var hearts = get_children()
	
	for i in range(currentHealth):
		hearts[i].update(true)
		
	for i in range(currentHealth, hearts.size()):
		hearts[i].update(false)
	
func remove_children():
	var children = get_children()
	if children == null:
		return
	for child in children:
		remove_child(child)
		child.queue_free()
