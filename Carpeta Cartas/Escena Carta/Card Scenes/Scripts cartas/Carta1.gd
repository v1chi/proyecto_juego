extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/2.tres"


func activar_efecto():
	print("Activa el efecto de la carta 1")



func _ready():
	super._ready()
	print("Ready de la clase concreta")
	


func _init(): 
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Carta 1"
