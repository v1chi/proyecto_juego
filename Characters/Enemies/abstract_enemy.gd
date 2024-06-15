class_name AbstractEnemy
extends CharacterBody2D


@export var speed: int = 15
@onready var animations = $AnimationPlayer
var player_chase = false
var player = null
var health = 2
var playerChase = false
var toAttack = false
var damaged = 2
var attack_damage = 1
var knockback = Vector2.ZERO
var score = 10
var path_puntuacion = "res://Characters/Enemies/puntuacion.tscn"
var show_score = false
signal death_signal


func _ready():
	add_to_group("Enemies")


func receive_damage(damage):
	health -= damage

func dead():
	pass

func enemy():
	pass

func hurted():
	pass

# Abstracto
func attack():
	pass


func mostrar_score():
	if not(show_score):
		return
	var anim_puntuacion = load(path_puntuacion).instantiate()
	anim_puntuacion.set_score(score)
	add_child(anim_puntuacion)
	anim_puntuacion.anim.play("mostrar_score")

