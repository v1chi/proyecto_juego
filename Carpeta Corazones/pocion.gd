extends CharacterBody2D

var health = 1
var moveDirection = Vector2.ZERO
var flag = false
var fuerza = Vector2.ZERO
var speed = 4
func _process(delta):
	var velocity = fuerza
	move_and_collide(velocity * delta)
	


func _on_area_acercamiento_body_entered(body):
	if body.has_method("player") and  body.currentHealth < body.maxHealth:
		var direction = global_position.direction_to(body.global_position).normalized()
		fuerza = direction * speed 
		



func _on_area_pocion_body_entered(body):
	if body.has_method("player") and  body.currentHealth < body.maxHealth:
		body.currentHealth += health
		queue_free()



func _on_area_acercamiento_body_exited(body):
	fuerza = Vector2.ZERO
