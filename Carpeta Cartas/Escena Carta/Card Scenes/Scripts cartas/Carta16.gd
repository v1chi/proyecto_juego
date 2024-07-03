extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/cartas_ia/Comodin/Resurrecion.png"
var player
var enemies_defeated_count
var timer
var escena_reducida = "res://Carpeta Cartas/vision_reducida.tscn"
var flag = true
var contador_efectos
var idle_timer

func _ready():
	super._ready()
	super.set_scale_carta_frontal(Vector2(0.143,0.155))
	super.set_scale_carta_trasera(Vector2(0.194,0.203))
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
	await anim.animation_finished
	anim.play("fade_out")


func desactivar_efecto():
	if player != null and player.revivePlayer.is_connected(_on_revive_player):
		player.revivePlayer.disconnect(_on_revive_player)

func get_icono():
	return path_carta_frontal
	
func _init():
	self.id = 16
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Revives"
	self.path_carta_trasera_imagen = "res://Carpeta Cartas/Escena Carta/cartas_ia/Parte Trasera Cartas/comodin trasero.png"
