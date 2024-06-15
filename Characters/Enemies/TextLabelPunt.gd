extends RichTextLabel

var score



func _ready():
	score = get_parent().get_score()
	self.text = "[wave amp=50.0 freq=5.0 connected=1]" + "+" + str(score) + "[/wave]"
	
