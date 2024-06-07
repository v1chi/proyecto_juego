extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/Q.tres"
var flag = true
var player
var enemies_defeated_count
var timer


var contador_efectos

func _ready():
	super._ready()
	print("Ready de la clase concreta")
	

func get_id():
	return id


func wait(seconds):
	await get_tree().create_timer(seconds).timeout
	pass

func _activar_efecto_hijo():
	
	player = Global.get_node("/root/world2/TileMap/char1")
	if !player.lowHealth.is_connected(_on_low_health_player):
		player.lowHealth.connect(_on_low_health_player)

func _on_timer_timeout_efecto(timer_):
	var enemies = Global.get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.attack_damage = 1
	timer_.queue_free()
	contador_efectos += 1
	if contador_efectos >= 2:
		return 
	else:
		await wait(15)
		_activar_efecto_hijo()

func _on_low_health_player():
	player.currentHealth += 3
	player.healthChanged.emit(player.currentHealth)
	var enemies = Global.get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.attack_damage = 2
	
	player.lowHealth.disconnect(_on_low_health_player)
	timer = _get_timer()
	timer.start()
	
	pass


func _get_timer():
	timer = Timer.new()
	timer.wait_time = 15
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout_efecto.bind(timer))
	GlobalCartas.add_sibling(timer)
	return timer



func get_icono():
	return path_carta_frontal
	
func _init():
	self.contador_efectos = 0
	self.id = 9
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "DON SUP"