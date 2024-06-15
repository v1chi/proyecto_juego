extends Node2D

var score 
var anim

func _ready():
	anim = $AnimationPlayer

func set_score(score):
	self.score = score

func get_score():
	return score
