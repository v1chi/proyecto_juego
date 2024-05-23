extends CharacterBody2D

var speed = 40
var playerChase = false
var player = null

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
	playerChase = true
