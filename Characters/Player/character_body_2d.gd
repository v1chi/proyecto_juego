extends CharacterBody2D

@export var speed: int = 50
@onready var animations = $AnimationPlayer
var lastAnimDirection: String = "Down"
var isAttacking: bool = false
@export var maxHealth = 5
var damaged = maxHealth
@onready var currentHealth: int = maxHealth

var path_menu = "res://Menu/menu.tscn"
signal healthChanged
signal lowHealth
signal revivePlayer
signal maxHealthChanged

var received_damage = 1
var enemy_inattack_range = false
var enemy_attack_cooldown = true

var custom_speed = 1
var knockback = preload("res://Carpeta Cartas/Escena Carta/Card Scenes/knockback.tscn").instantiate()

var player_attack_cooldown = false
var can_revive = false

@onready var idle_timer = $IdleTimer
@onready var attack_cooldown_timer = $attack_cooldown

func _ready():
	add_to_group("Player")
	maxHealthChanged.connect(_on_set_maxHealth)
	attack_cooldown_timer.wait_time = 0.7  

func start_timer_idle():
	if idle_timer.is_stopped():
		idle_timer.start()

func stop_timer_idle():
	if not(idle_timer.is_stopped()):
		idle_timer.stop()

func handleInput():
	var moveDirection = Input.get_vector("left", "right", "up", "down")
	velocity = moveDirection * speed * 2
	
	if Input.is_action_just_pressed("attack"):
		if not isAttacking and not player_attack_cooldown:
			player_attack_cooldown = true
			isAttacking = true
			animations.play("attack" + lastAnimDirection, -1, custom_speed, false)
			$audioAtaque.play()
			await animations.animation_finished
			isAttacking = false
			$attack_cooldown2.start()
	
func updateAnimation():
	if isAttacking:
		return
	
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
	if currentHealth == 1:
		lowHealth.emit() 
	elif currentHealth <= 0:
		set_physics_process(false)
		await hurted()
		await dead()
	if damaged > currentHealth:
		await hurted()
		damaged = currentHealth
	elif damaged < currentHealth:
		damaged = currentHealth
	
	
	handleInput()
	move_and_slide()
	updateAnimation()
	enemy_attack()
	set_physics_process(true)

func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass
	
func dead():
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
	set_physics_process(true)

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		
func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown:
		currentHealth -= received_damage
		enemy_attack_cooldown = false
		attack_cooldown_timer.start()
		
func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
func hurted():
	$AnimationPlayer2.play("hurted")
	#await $AnimationPlayer.animation_finished

func _on_set_maxHealth():
	damaged = maxHealth

func set_maxHealth(health : int):
	maxHealth = health
	maxHealthChanged.emit()

func player():
	pass


func _on_attack_cooldown_2_timeout():
	player_attack_cooldown = false
