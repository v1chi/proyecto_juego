extends Area2D

# Ruta de la nueva escena
const SECONDARY_SCENE_PATH = "res://Scene/w1l2.tscn"
var menu = "res://Menu/menu.tscn"


# Función que se ejecuta cuando un cuerpo entra en el área
func _on_Area2D_body_entered(body):
	# Verifica si el cuerpo que entra es el personaje "Char1"
	if body.name == "char1":
		change_scene(menu)

# Función para cambiar de escena
func change_scene(scene_path):
	Global.goto_scene(scene_path)

# Conectar la señal del área para detectar la entrada de un cuerpo
func _ready():
	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))



