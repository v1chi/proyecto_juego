extends CharacterBody2D

@export var speed: int = 50
@onready var animations = $AnimationPlayer
var lastAnimDirection: String = "Down"
var isAttacking: bool = false
@export var maxHealth = 5
@onready var currentHealth: int = maxHealth


var path_menu = "res://Menu/menu.tscn"
signal healthChanged
signal lowHealth
signal revivePlayer

var received_damage = 1
var enemy_inattack_range = false
var enemy_attack_cooldown = true

var custom_speed = 1
var knockback = preload("res://Carpeta Cartas/Escena Carta/Card Scenes/knockback.tscn").instantiate()

var can_revive = false
## Carta impl idle

@onready var idle_timer = $IdleTimer

func start_timer_idle():
	if idle_timer.is_stopped():
		idle_timer.start()

func stop_timer_idle():
	if not(idle_timer.is_stopped()):
		idle_timer.stop()

## Carta impl idle

func handleImput():
	var moveDirection = Input.get_vector("left", "right", "up", "down")
	velocity = moveDirection*speed*2
	
	if Input.is_action_just_pressed("attack"):
		animations.play("attack" + lastAnimDirection, -1, custom_speed, false)
		isAttacking = true
		$audioAtaque.play()
		await animations.animation_finished
		isAttacking = false
		
	
func updateAnimation():
	if isAttacking: return
	
	if velocity.length() == 0:
		animations.play("walkStand")
		start_timer_idle()
	
	else:
		stop_timer_idle()
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
	
	healthChanged.emit(currentHealth)
	if  currentHealth == 1:
		lowHealth.emit() 
	elif currentHealth <= 0:
		await dead()
		
	
	handleImput()
	move_and_slide()
	updateAnimation()
	enemy_attack()


func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass
	
func dead():
	set_physics_process(false)
	animations.play("deathLeft")
	$audioMuerte.play()
	await animations.animation_finished
	await wait(0.6)
	if can_revive:
		await _on_revive_card()
	else:
		Global.goto_scene(path_menu)
	

func _on_revive_card():
	revivePlayer.emit()
	enemy_attack_cooldown = false
	animations.play_backwards("deathLeft")
	add_child(knockback)
	currentHealth = maxHealth
	healthChanged.emit(currentHealth)
	await animations.animation_finished 
	remove_child(knockback)
	$attack_cooldown.start()
	set_physics_process(true)
	
	
	

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		
		
func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		currentHealth -= received_damage
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		
		
func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
func player():
	pass
