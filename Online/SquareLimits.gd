class_name SquareLimits
extends Node2D

var rng = RandomNumberGenerator.new()
const CASILLA_TAM = 16 # Pixeles
var cantidad_casillas_horizontal = 10
var cantidad_casillas_vertical = 5

var min_pos_x
var max_pos_x 
var min_pos_y
var max_pos_y


func _ready():
	min_pos_x = position.x - cantidad_casillas_horizontal/2 * CASILLA_TAM
	min_pos_y = position.y - cantidad_casillas_vertical/2 * CASILLA_TAM 
	max_pos_x = position.x + cantidad_casillas_horizontal/2 * CASILLA_TAM
	max_pos_y = position.y + cantidad_casillas_vertical/2 * CASILLA_TAM
	
# UNA posicion random y válidad
func get_posicion_valida():
	var x = rng.randf_range(min_pos_x, max_pos_x)
	var y = rng.randf_range(min_pos_y, max_pos_y)
	return Vector2(x, y)
