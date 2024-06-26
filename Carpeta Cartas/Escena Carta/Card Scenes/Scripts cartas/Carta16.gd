extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/Q.tres"
var player
var enemies_defeated_count
var timer
var escena_reducida = "res://Carpeta Cartas/vision_reducida.tscn"
var flag = true
var contador_efectos
var idle_timer

func _ready():
	super._ready()
	print("Ready de la clase concreta")
	

func get_id():
	return id


func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass



func _activar_efecto_hijo():
	if not(flag):
		return
	flag = false
	player = Global.get_tree().get_nodes_in_group("Player")[0]
	player.revivePlayer.connect(_on_revive_player)
	player.can_revive = true

func _on_revive_player():
	player.revivePlayer.disconnect(_on_revive_player)
	player.can_revive = false
	anim.play("activa_inst", -1, 0.6, false)


func _on_idle_timeout():
	if player.currentHealth < player.maxHealth:
		player.currentHealth += 1
		player.healthChanged.emit(player.currentHealth)
	
	pass






func get_icono():
	return path_carta_frontal
	
func _init():
	self.id = 16
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Revives"
