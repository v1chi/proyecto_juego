extends Control


var text_pos : RichTextLabel
var text_name : RichTextLabel
var text_score : RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	text_pos = $PLabel/HBoxContainer/PPos/Pos
	text_name = $PLabel/HBoxContainer/PName/Name
	text_score = $PLabel/HBoxContainer/PScore/Score
	pass # Replace with function body.


func set_text_pos(posicion : String):
	text_pos.text = posicion 

func set_text_name(name : String):
	text_name.text = name

func set_text_score(score : String):
	text_score.text = score


func get_text_pos():
	return text_pos.text

func get_text_name():
	return text_name.text

func get_text_score():
	return text_score.text
