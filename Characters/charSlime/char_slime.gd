extends CharacterBody2D

var speed = 40
var playerChase = false
var player = null
var health = 1

func _physics_process(delta):
	if playerChase:
		position += (player.position - position)/speed
		
		$AnimationPlayer.play("walkRight")
		
		if(player.position.x - position.x) < 0:
			$AnimationPlayer.play("walkLeft")
	else:
		$AnimationPlayer.play("walkStand")

func _on_detection_body_entered(body):
	player = body
	playerChase = true

func _on_detection_body_exited(body):
	player = null
	playerChase = false
	
func _on_enemy_hitbox_area_entered(area):
	if area.name == "WeaponArea2D":
		health -= 1
		if health == 0:
			dead()

func dead():
	set_physics_process(false)
	queue_free()

func enemy():
	pass
