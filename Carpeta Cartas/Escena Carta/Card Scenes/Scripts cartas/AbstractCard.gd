class_name AbstractCard 
extends Node2D


const PATH_ESCENA_CARTA : String = "res://Carpeta Cartas/Escena Carta/Card Scenes/card.tscn"
var imagen_carta : Resource = preload("res://Carpeta Cartas/Escena Carta/Card Scenes/Don_sup.png")


var sprite_carta : Sprite2D
var anim : AnimationPlayer


var descripcion_carta : String = "Carta abstracta"
var id : int

signal card_created
signal card_effected


func clone():
	var path_script = self.get_script().get_path()
	var carta_clone = load(PATH_ESCENA_CARTA).instantiate()
	carta_clone.set_script(load(path_script))
	return carta_clone
	
func get_icono():
	pass
	
func _activar_efecto_hijo():
	push_error("ERROR DE NO IMPLEMENTACIÓN DEL MÉTODO: activar_efecto_hijo()")
	
func activar_efecto():
	card_effected.emit()
	_activar_efecto_hijo()
	
func get_id():
	push_error("ERROR DE NO IMPLEMENTACIÓN DEL MÉTODO: get_id()")

func on_card_created():
	print("Carta creada ")
	card_created.emit()

func get_descripcion():
	return self.descripcion_carta

func set_carta_frontal(texture_load):
	assert(sprite_carta != null, "Nodo Sprite2D de la carta frontal es nulo")
	sprite_carta.set_texture(texture_load)


func activate_card_flip():
	assert(anim != null, "Animation player es nulo")
	anim.play("card_flip")
	
func activate_shift_animation():
	assert(anim != null, "Animation player es nulo")
	anim.play("shift")

func activate_discard_card():
	assert(anim != null, "Animation Player es nulo")
	anim.play("discard_animation")



func _ready():
	assert(get_node("card/AnimationPlayer") != null, "AnimationPlayer es nulo")
	assert(get_node("card/cardback/frontal") != null, "Sprite2D de la carta frontal es nulo")
	
	sprite_carta = get_node("card/cardback/frontal")
	anim = get_node("card/AnimationPlayer")
	
	set_carta_frontal(imagen_carta)

