extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/CuteCards - asset pack/cartas_separadas/Q.tres"
var flag = true
var player
var enemies_defeated_count

func _ready():
	super._ready()
	print("Ready de la clase concreta")
	

func get_id():
	return id

func _activar_efecto_hijo():
	player = Global.get_tree().get_nodes_in_group("Player")[0]
	var enemies = Global.get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.death_signal.connect(_on_enemy_defeated.bind(enemy))


func _on_enemy_defeated(enemy):
	enemy.death_signal.disconnect(_on_enemy_defeated)
	anim.play("activa_inst")
	enemies_defeated_count += 1
	print(enemies_defeated_count)
	if enemies_defeated_count % 2 == 0 and player.currentHealth < player.maxHealth:
		player.currentHealth += 1
		player.healthChanged.emit(player.currentHealth)


func get_icono():
	return path_carta_frontal
	
func _init(): 
	self.enemies_defeated_count = 0
	self.id = 8
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Recuperas una vida al matar dos enemigos"
