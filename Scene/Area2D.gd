extends Area2D

# Ruta de la nueva escena
const SECONDARY_SCENE_PATH = "res://Scene/w1l2.tscn"

# Función que se ejecuta cuando un cuerpo entra en el área
func _on_Area2D_body_entered(body):
	# Verifica si el cuerpo que entra es el personaje "Char1"
	if body.name == "char1":
		change_scene(SECONDARY_SCENE_PATH)

# Función para cambiar de escena
func change_scene(scene_path):
	# Obtén el nodo de la escena actual
	var current_scene = get_tree().current_scene
	# Carga la nueva escena
	var new_scene = load(scene_path).instantiate()
	# Reemplaza la escena actual con la nueva escena
	get_tree().current_scene = new_scene
	# Añade la nueva escena a la raíz
	get_tree().root.add_child(new_scene)
	# Elimina la escena actual de la raíz
	current_scene.queue_free()

# Conectar la señal del área para detectar la entrada de un cuerpo
func _ready():
	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))



