extends Node2D

var top_left : SquareLimits
var top_right : SquareLimits
var bottom_left : SquareLimits
var bottom_right : SquareLimits

# Called when the node enters the scene tree for the first time.
func _ready():
	top_left = $TopLeft
	top_right = $TopRight
	bottom_left = $BottomLeft
	bottom_right = $BottomRight

func get_pos_valida_top_left():
	return top_left.get_posicion_valida()

func get_pos_valida_top_right():
	return top_right.get_posicion_valida()

func get_pos_valida_bottom_left():
	return bottom_left.get_posicion_valida()

func get_pos_valida_bottom_right():
	return bottom_right.get_posicion_valida()

func get_pos_valida_azar():
	var random_position = randi() % 4
	if random_position == 0:
		return get_pos_valida_top_left()
	elif random_position == 1:
		return get_pos_valida_top_right()
	elif random_position == 2:
		return get_pos_valida_bottom_left()
	else:
		return get_pos_valida_bottom_right()

func _init():
	randomize()
