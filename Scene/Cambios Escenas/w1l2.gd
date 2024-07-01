extends Area2D

# Ruta de la nueva escena
var SECONDARY_SCENE_PATH = "res://Scene/w1l3.tscn"
var menu = "res://Menu/menu.tscn"


# Función que se ejecuta cuando un cuerpo entra en el área
func _on_Area2D_body_entered(body):
	# Verifica si el cuerpo que entra es el personaje "Char1"
	if body.name == "char1":
		change_scene("res://Carpeta Cartas/Escena Selección/Eleccion_carta_final.tscn")

# Función para cambiar de escena
func change_scene(scene_card_path):
	Global.goto_scene_card_to_world(scene_card_path, SECONDARY_SCENE_PATH)

# Conectar la señal del área para detectar la entrada de un cuerpo
func _ready():
	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	
