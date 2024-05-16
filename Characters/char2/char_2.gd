extends CharacterBody2D

@export var speed: int = 35
@onready var animations = $AnimationPlayer
@export var limit: float = 0.5

var startPosition
var endPosition

@onready var animationsChar = $AnimationPlayer

func _ready():
	startPosition = position
	endPosition = startPosition + Vector2(0, 2*16)

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized()*speed
	
func updateAnimation():
	var animationString = "walkUp"
	if velocity.y > 0:
		animationString = "walkDown"
	animationsChar.play(animationString)
	
func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
