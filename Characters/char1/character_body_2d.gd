extends CharacterBody2D

@export var speed: int = 35
@onready var animations = $AnimationPlayer
var lastAnimDirection: String = "Down"
var isAttacking: bool = false

@export var maxHealth = 5
@onready var currentHealth: int = maxHealth
signal healthChanged

func handleImput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection*speed
	
	if Input.is_action_just_pressed("attack"):
		animations.play("attack" + lastAnimDirection)
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
	handleImput()
	move_and_slide()
	updateAnimation()


func _on_hurtbox_area_entered(area):
	if area.name == "Hitbox":
		currentHealth -= 1
		if currentHealth == 0:
			#currentHealth = maxHealth
			dead()
		healthChanged.emit(currentHealth)

func dead():
	set_physics_process(false)
	animations.play("deathLeft")
	await animations.animation_finished
	queue_free()
