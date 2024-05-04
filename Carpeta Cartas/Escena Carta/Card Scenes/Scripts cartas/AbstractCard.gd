class_name AbstractCard 
extends Node2D


var imagen_carta = preload("res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/JOKER_ROJO.tres")
var sprite_carta
var anim
var descripcion_carta
var id : int
signal card_created




func activar_efecto():
	push_error("ERROR DE NO IMPLEMENTACIÓN DEL MÉTODO: activar_efecto()")
	
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
	
	anim = get_node("card/AnimationPlayer")
	sprite_carta = get_node("card/cardback/frontal")
	
	activate_shift_animation()
	set_carta_frontal(imagen_carta)

