extends CharacterBody2D

@export var speed: int = 35
@onready var animations = $AnimationPlayer
var lastAnimDirection: String = "Down"
var isAttacking: bool = false

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
