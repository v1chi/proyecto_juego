extends Node



var path_slime = "res://Characters/Enemies/charSlime/char_slime.tscn"
var efecto_1 : String
var efecto_2 : String

func _init():
	efecto_1 = "_desactivo"
	efecto_2 = "_desactivo"

func instanciar_slime():
	var enemy : AbstractEnemy = load(path_slime).instantiate()
	enemy.show_score = true
	var call_efecto1 : Callable = Callable(self, efecto_1)
	var call_efecto2 : Callable = Callable(self, efecto_2)
	return call_efecto1.call(call_efecto2.call(enemy))



func _desactivo(enemy : AbstractEnemy):
	print("normal")
	return enemy
	


#Aumento de Velocidad enemigos
func _on_active_carta6(enemy : AbstractEnemy):
	enemy.speed += 5
	enemy.patrol_speed += 5
	enemy.custom_speed_animation = 1.5
	return enemy

# Enemigos Reciben Doble de daño
func _on_active_carta7(enemy : AbstractEnemy):
	enemy.attack_damage = enemy.attack_damage*2
	return enemy


var carta8
# Recuperas vida al matar enemigos
func _on_active_carta8(enemy : AbstractEnemy):
	if carta8 == null:
		return enemy
	carta8.connect_death_signal(enemy)
	return enemy

# Don Sup
func _on_active_carta9(enemy : AbstractEnemy):
	print("9")
	return enemy
	

# Enemigos reciben menos daño
func _on_active_carta12(enemy : AbstractEnemy):
	enemy.attack_damage = enemy.attack_damage/2
	return enemy 

var carta13
# Recibes daño al matar enemigos
func _on_active_carta13(enemy : AbstractEnemy):
	if carta13 == null:
		return enemy
	carta13.connect_death_signal(enemy)
	return enemy


func reset_efectos():
	efecto_1 = "_desactivo"
	efecto_2 = "_desactivo"

func agregar_efecto(efecto : String):
	if efecto_1 == "_desactivo":
		efecto_1 = efecto
	elif efecto_2 == "_desactivo":
		efecto_2 = efecto



