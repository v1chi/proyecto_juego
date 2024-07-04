class_name AbstractEnemy
extends CharacterBody2D


@export var speed: int = 15
@onready var animations = $AnimationPlayer
@export var patrol_speed: int = 10
var player_chase = false
var player = null
var health = 8
var playerChase = false
var toAttack = false
var damaged = 2
var attack_damage = 4 # Daño que recibe
var knockback = Vector2.ZERO
var score = 10
var path_puntuacion = "res://Characters/Enemies/puntuacion.tscn"
var show_score = false
var anim
var custom_speed_animation = 1
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


func desactivar_fisicas(time):
	set_physics_process(false)
	await Global.wait(time)
	set_physics_process(true)


func mostrar_score():
	if not(show_score):
		return
	var anim_puntuacion = load(path_puntuacion).instantiate()
	anim_puntuacion.set_score(score)
	add_child(anim_puntuacion)
	anim_puntuacion.anim.play("mostrar_score")

