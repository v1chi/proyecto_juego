extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/3.tres"

func _ready():
	super._ready()
	print("Ready de la clase concreta")
	


func _init(): 
	self.imagen_carta = load(path_carta_frontal)
