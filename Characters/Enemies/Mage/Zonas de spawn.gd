extends Node2D

signal emitir_efecto

var particula = "res://Characters/Enemies/Mage/Efectos_mago/mageAttack.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	emitir_efecto.connect(_on_emitir_efecto)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_emitir_efecto():
	var part = load(particula).instantiate()
	$Area2D.add_child(part)
	part.set_emitting(true)
	pass
