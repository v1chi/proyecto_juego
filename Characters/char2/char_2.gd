extends CharacterBody2D

@export var speed: int = 15
@onready var animations = $AnimationPlayer
var player_chase = false
var player = null
var health = 2

func _physics_process(delta):
	if player_chase:
		var moveDirection = player.position - position
		var velocity1 = moveDirection.normalized() * speed
		
		#position += velocity * delta
		var coll = move_and_collide(velocity1*delta)
		if coll:
			
			print(coll.get_collider().name)
		updateAnimation(moveDirection)
	else:
		animations.play("RESET")

func updateAnimation(direction):
	var xComponent = abs(direction.x)
	var yComponent = abs(direction.y)
	var animationName = "attackDown"

	if xComponent > yComponent:
		if direction.x > 0:
			animationName = "attackRight"
		else:
			animationName = "attackLeft"
	else:
		if direction.y > 0:
			animationName = "attackDown"
		else:
			animationName = "attackUp"

	animations.play(animationName)

func enemy():
	pass
	
func _on_detection_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true

func _on_detection_body_exited(body):
	if body.has_method("player"):
		player = null
		player_chase = false


func _on_enemy_hitbox_area_entered(area):
	if area.name == "WeaponArea2D":
		health -= 1
		if health == 0:
			dead()

func dead():
	set_physics_process(false)
	queue_free()
		
