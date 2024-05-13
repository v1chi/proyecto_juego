extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/4.tres"

func _ready():
	super._ready()
	print("Ready de la clase concreta")
	

func get_id():
	return id

func _activar_efecto_hijo():
	print("Activa el efecto de la carta 3")
	

func _init(): 
	self.id = 3
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Carta 3"
