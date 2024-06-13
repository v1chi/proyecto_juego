extends Control


var text_score

# Called when the node enters the scene tree for the first time.
func _ready():
	text_score = $RichTextLabel
	Global.update_score.connect(_on_update_score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_update_score():
	text_score.text = "Score: " + str(Global.score)
	print(Global.score)
