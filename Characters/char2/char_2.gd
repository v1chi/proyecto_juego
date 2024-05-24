extends CharacterBody2D

@export var speed: int = 20
@onready var animations = $AnimationPlayer
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		var moveDirection = player.position - position
		var velocity = moveDirection.normalized() * speed
		position += velocity * delta
		
		updateAnimation(moveDirection)
	else:
		animations.play("RESET")

func updateAnimation(direction):
	var xComponent = abs(direction.x)
	var yComponent = abs(direction.y)
	var animationName = "idle"

	if xComponent > yComponent:
		if direction.x > 0:
			animationName = "walkRight"
		else:
			animationName = "walkLeft"
	else:
		if direction.y > 0:
			animationName = "walkDown"
		else:
			animationName = "walkUp"

	animations.play(animationName)

	
func _on_detection_body_entered(body):
	player = body
	player_chase = true

func _on_detection_body_exited(body):
	player = null
	player_chase = false


