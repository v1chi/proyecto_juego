extends AbstractCard

var path_carta_frontal = "res://Carpeta Cartas/Escena Carta/cartas_ia/Cartas buenas/Transfucion del guerrero.png"
var flag = true
var player
var enemies_defeated_count

func _ready():
	super._ready()
	super.set_scale_carta_frontal(Vector2(0.13,0.154))
	super.set_scale_carta_trasera(Vector2(0.21,0.21))
	print("Ready de la clase concreta")
	

func get_id():
	return id

func _activar_efecto_hijo():
	FactoryEnemy.carta8 = self
	FactoryEnemy.agregar_efecto("_on_active_carta8")
	player = Global.get_tree().get_nodes_in_group("Player")[0]
	var enemies = Global.get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		connect_death_signal(enemy)

func _on_enemy_defeated(enemy):
	enemy.death_signal.disconnect(_on_enemy_defeated)
	anim.play("activa_inst")
	enemies_defeated_count += 1
	print(enemies_defeated_count)
	if enemies_defeated_count % 2 == 0 and player.currentHealth < player.maxHealth:
		player.currentHealth += 1
		player.healthChanged.emit(player.currentHealth)

func connect_death_signal(enemy):
	if enemy != null:
		enemy.death_signal.connect(_on_enemy_defeated.bind(enemy))


func disconnect_death_signal(enemy):
	if enemy != null and enemy.death_signal.is_connected(_on_enemy_defeated):
		enemy.death_signal.disconnect(_on_enemy_defeated)
		

func desactivar_efecto():
	var enemies = Global.get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		disconnect_death_signal(enemy)


func get_icono():
	return path_carta_frontal
	
func _init(): 
	self.enemies_defeated_count = 0
	self.id = 8
	self.imagen_carta = load(path_carta_frontal)
	self.descripcion_carta = "Recuperas una vida al matar dos enemigos"
	self.path_carta_trasera_imagen = "res://Carpeta Cartas/Escena Carta/cartas_ia/Parte Trasera Cartas/carta_trasera_buena.png"
