extends Area2D


var collision
var circle_shape
var vel = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	collision = $CollisionShape2D
	circle_shape = collision.get_shape()
	circle_shape.radius = lerp(0, 50, 1)
	
	
	pass # Replace with function body.

var knockback = Vector2.ZERO
var knockback_strength = 100
func _on_body_entered(body):
	if body.has_method("enemy"):
		var direction = global_position.direction_to(body.global_position).normalized()
		var explosion_force = direction * knockback_strength
		body.knockback = explosion_force

