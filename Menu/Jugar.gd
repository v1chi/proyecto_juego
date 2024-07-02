extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var cambio1 = ("res://Menu/pantalla carga.tscn")
var cambio = "res://Carpeta Cartas/Escena Selección/Eleccion_carta_final.tscn"
var world1 = "res://Scene/w1l1.tscn"
func _on_pressed():
	Global.score = 0
	Global.goto_scene_card_to_world(cambio, world1)


