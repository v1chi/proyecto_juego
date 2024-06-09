extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/Q.tres"
var player
var enemies_defeated_count
var timer
var escena_reducida = "res://Carpeta Cartas/vision_reducida.tscn"
var flag = true
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
	player = Global.get_tree().get_nodes_in_group("Player")[0]
	var enemies = Global.get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.death_signal.connect(_on_enemy_defeated.bind(enemy))


func _on_enemy_defeated(enemy):
	enemy.death_signal.disconnect(_on_enemy_defeated)
	enemies_defeated_count += 1
	print(enemies_defeated_count)
	if enemies_defeated_count % 5 == 0:
		player.currentHealth -= 1
		player.healthChanged.emit(player.currentHealth)




func get_icono():
	return path_carta_frontal
	
func _init():
	self.enemies_defeated_count = 0
	self.contador_efectos = 0
	self.id = 13
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Recibes daño al matar 5 enemigos"
