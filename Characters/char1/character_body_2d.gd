extends CharacterBody2D

@export var speed: int = 45
@onready var animations = $AnimationPlayer
var lastAnimDirection: String = "Down"
var isAttacking: bool = false
@export var maxHealth = 5
@onready var currentHealth: int = maxHealth

signal healthChanged
signal lowHealth


var enemy_inattack_range = false
var enemy_attack_cooldown = true

var custom_speed = 1

func handleImput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection*speed
	
	if Input.is_action_just_pressed("attack"):
		animations.play("attack" + lastAnimDirection, -1, custom_speed, false)
		isAttacking = true
		await animations.animation_finished
		isAttacking = false
	
func updateAnimation():
	if isAttacking: return
	
	if velocity.length() == 0:
		animations.play("walkStand")
	else:
		var direction = "Down"
		if velocity.x < 0: 
			direction = "Left"
		elif velocity.x > 0: 
			direction = "Right"
		elif velocity.y < 0: 
			direction = "Up"
			
		animations.play("walk" + direction) 
		lastAnimDirection = direction

func _physics_process(delta):
	
	if  currentHealth == 1:
		lowHealth.emit() 
	elif currentHealth == 0:
		dead()
	healthChanged.emit(currentHealth)
	handleImput()
	move_and_slide()
	updateAnimation()
	enemy_attack()
	
func dead():
	set_physics_process(false)
	animations.play("deathLeft")
	await animations.animation_finished
	queue_free()

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		
		
func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		currentHealth -= 1
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		
func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
func player():
	pass
