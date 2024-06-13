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
signal death_signal





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


