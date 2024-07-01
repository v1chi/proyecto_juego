extends Control


var text_score
var interval_score
var current_score
var anim : AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	current_score = 0
	anim = $AnimationPlayer
	text_score = $ParentPanel/Panel/RichTextLabel
	Global.update_score.connect(_on_update_score)
	pass # Replace with function body.



func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_update_score():
	var inter = 10
	var cont = 0
	interval_score = range(current_score, Global.score, inter)
	for i in interval_score:
		text_score.text = str(i)
		anim.play("add")
		if cont % 2  == 0:
			cont += 1
			await anim.animation_finished
		else:
			await wait(0.05)
		
	current_score = Global.score 
	text_score.text = str(current_score)
	




func _on_button_pressed(arg):
	Global.score_agregate(arg)

