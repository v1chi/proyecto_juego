extends Node

var carta1 : AbstractCard
var carta2 : AbstractCard

var count

var escena_carta = load("res://Carpeta Cartas/Escena Carta/Card Scenes/card.tscn")

func set_carta(script):
	if count == 0:
		carta1 = escena_carta.instantiate()
		carta1.set_script(script)
		count += 1
	else:
		carta2 = escena_carta.instantiate()
		carta2.set_script(script)
		count = 0


func activar_efectos():
	carta1.activar_efecto()
	carta2.activar_efecto()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
