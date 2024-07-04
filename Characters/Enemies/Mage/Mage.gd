extends AbstractEnemy

var last_direction = Vector2.ZERO
var buffVida = false

func _init():
	self.speed = 30
	self.health = 30
	self.damaged = self.health
	self.score = 700


func _physics_process(delta):
	if health <= 0:
		set_physics_process(false)
		death_signal.emit()
		await hurted()
		await dead()
	else:
		if buffVida == false:
			damaged += 15
			health += 15
			buffVida = true
		if damaged != health:
			await hurted()
			damaged = health
		if toAttack == true:
			await attack()		
		procesamiento(delta)

func procesamiento(delta):
	if playerChase:
		var moveDirection = -player.position + position
		last_direction = moveDirection.normalized()  # Guardar la última dirección de movimiento
		var velocity = moveDirection.normalized() * speed + knockback
		var coll = move_and_collide(velocity * delta)
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
			animationName = "walkDown"
		elif direction.y < 0:
			animationName = "walkUp"
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
	$"Zonas de muerte".emitir_efecto.emit()
	mostrar_score()
	await $AnimationPlayer.animation_finished
	Global.score_agregate(score)
	queue_free()

func hurted():
	$AnimationPlayer.play("hurted")
	await $AnimationPlayer.animation_finished

func _on_attack_detector_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	toAttack = true

func attack():
	set_physics_process(false)
	var attack_animation = "attackDown"  # Valor por defecto
	if abs(last_direction.x) > abs(last_direction.y):
		if last_direction.x < 0:
			attack_animation = "attackRight"
		else:
			attack_animation = "attackLeft"
	else:
		if last_direction.y < 0:
			attack_animation = "attackDown"
		else:
			attack_animation = "attackUp"
			
	$"Zonas de spawn".emitir_efecto.emit()
	$AnimationPlayer.play(attack_animation)
	await $AnimationPlayer.animation_finished
	set_physics_process(true)
	toAttack = false
