extends AbstractEnemy

@onready var efectoCaminar = $caminar
@onready var efectMuerte = $muerte

@export var patrol_distance: int = 200
var patrol_direction: int = 1
var start_position: Vector2


func _init():
	self.speed = 15
	self.health = 4
	self.score = 5
	self.damaged = self.health
	

func _ready():
	efectoCaminar.play()
	super._ready()
	start_position = position


func _physics_process(delta):
	if health <= 0:
		set_physics_process(false)
		self.death_signal.emit()
		await hurted()
		await dead()
	else:
		if damaged != health:
			await hurted()
			damaged = health
		if toAttack == true:
			await attack()		
		procesamiento(delta)

func procesamiento(delta):
	if playerChase:
		var moveDirection = player.position - position
		var velocity = moveDirection.normalized() * speed + knockback
		var coll = move_and_collide(velocity * delta)
		updateAnimation(moveDirection)
	else:
		patrullar(delta)
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
	$AnimationPlayer.play(animationName, -1, custom_speed_animation, false)
	

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
	set_physics_process(false)
	$AnimationPlayer.play("deathRight", -1, 2, false)
	mostrar_score()
	efectMuerte.play()
	await $AnimationPlayer.animation_finished
	Global.score_agregate(score)
	queue_free()	

func hurted():
	$AnimationPlayer.play("hurted")
	await $AnimationPlayer.animation_finished

func _on_attack_detector_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	toAttack = true

func attack():
	set_process(false)
	set_physics_process(false)
	$AnimationPlayer.play("attack")
	await $AnimationPlayer.animation_finished
	set_physics_process(true)
	toAttack = false	

func patrullar(delta):
	var moveDirection = Vector2(patrol_direction, 0)
	var velocity = moveDirection * patrol_speed * delta
	var coll = move_and_collide(velocity)
	
	if coll:
		patrol_direction *= -1

	if abs(position.x - start_position.x) > patrol_distance:
		patrol_direction *= -1

	updateAnimation(moveDirection)
