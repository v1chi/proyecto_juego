extends CharacterBody2D

var speed = 20
var playerChase = false
var toAttack = false
var player = null
var health = 8
var damaged = 2
var attack_damage = 4


var knockback = Vector2.ZERO

signal death_signal

func _physics_process(delta):
	if health <= 0:
		self.death_signal.emit()
		await hurted()
		await dead()
		print("pasa")
		
	else:
		if damaged != health:
			await hurted()
			damaged = health
		if toAttack == true:
			await attack()		
		procesamiento(delta)
		
#velocity = direction * speed + knockback
#look_at(get_global_mouse_position())
#move_and_slide()
#knockback = lerp(knockback, Vector2.ZERO, 0.1)
func procesamiento(delta):
	if playerChase:
		var moveDirection = player.position - position
		var velocity = moveDirection.normalized() * speed + knockback
		var coll = move_and_collide(velocity * delta)
		if coll:
			print(coll.get_collider().name)
		updateAnimation(moveDirection)
	else:
		var moveDirection = Vector2.ZERO
		var velocity = moveDirection.normalized() * speed + knockback
		var coll = move_and_collide(velocity * delta)
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
		health -= attack_damage

func dead():
	set_physics_process(false)
	$AnimationPlayer.play("deathRight")
	await $AnimationPlayer.animation_finished
	queue_free()

func enemy():
	pass

func hurted():
	$AnimationPlayer.play("hurted")
	await $AnimationPlayer.animation_finished

func _on_attack_detector_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	toAttack = true

func attack():
	set_physics_process(false)
	$AnimationPlayer.play("attack")
	await $AnimationPlayer.animation_finished
	set_physics_process(true)
	toAttack = false

