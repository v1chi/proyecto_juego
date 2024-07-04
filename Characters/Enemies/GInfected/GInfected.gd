extends AbstractEnemy

@onready var daño = $caminar
@onready var muerte = $muerte

func _init():
	speed = 20
	toAttack = false
	score = 5
	
func _physics_process(delta):
	if health <= 0:
		set_physics_process(false)
		death_signal.emit()
		await hurted()
		await attack()	
		await dead()
	else:
		if damaged != health:
			await hurted()
			damaged = health
		procesamiento(delta)

func procesamiento(delta):
	if playerChase:
		var moveDirection = player.position - position
		var velocity = moveDirection.normalized() * speed + knockback
		var coll = move_and_collide(velocity * delta * 1.5)
		updateAnimation(moveDirection)
	else:
		$AnimationPlayer.play("walkStand")
	knockback = lerp(knockback, Vector2.ZERO, 0.05)

func updateAnimation(direction):
	var xComponent = abs(direction.x)
	var yComponent = abs(direction.y)
	var animationName = "walkStand"
	if xComponent > yComponent:
		if direction.x > 0:
			animationName = "walkRight"
		else:
			animationName = "walkLeft"
	else:
		if direction.y > 0:
			animationName = "walkRight" #down
		elif direction.y < 0:
			animationName = "walkLeft" #up
		else:
			animationName = "walkStand"
	$AnimationPlayer.play(animationName)

func _on_detection_body_entered(body):
	if body.has_method("player"):
		player = body
		playerChase = true

func _on_detection_body_exited(body):
	if body.has_method("player"):
		player = null
		playerChase = false

func _on_enemy_hitbox_area_entered(area):
	if area.name == "WeaponArea2D":
		receive_damage(attack_damage)

func dead():
	$AnimationPlayer.play("deathRight")
	mostrar_score()
	muerte.play()
	await $AnimationPlayer.animation_finished
	Global.score_agregate(score)
	queue_free()

func hurted():
	$AnimationPlayer.play("hurted")
	daño.play()
	await $AnimationPlayer.animation_finished
