class_name ControladorSpawn
extends Node


var array_path_enemigos : Array
var rng = RandomNumberGenerator.new()


const PATH_SLIME : String = "res://Characters/Enemies/charSlime/char_slime.tscn"
const PATH_GINFECTED : String = "res://Characters/Enemies/GInfected/GInfected.tscn"
const PATH_GSPEAR : String = "res://Characters/Enemies/GSpear/GSpear.tscn"
const PATH_GSWORD : String = "res://Characters/Enemies/GSword/GSword.tscn"
const PATH_MAGE : String = "res://Characters/Enemies/Mage/Mage.tscn"
const PATH_GOLEM : String = "res://Characters/Enemies/Golem1/Golem1.tscn"



const RONDA1 : String = "_primera_ronda"
const RONDA2 : String = "_segunda_ronda"
const RONDA3 : String = "_tercera_ronda"
const RONDA4 : String = "_cuarta_ronda"
const RONDA5 : String = "_quinta_ronda"
const RONDA6 : String = "_sexta_ronda"
const RONDA7 : String = "_septima_ronda"
const RONDA8 : String = "_octava_ronda"
const RONDA9 : String = "_novena_ronda"
const RONDA10 : String = "_decima_ronda"

func _primera_ronda():
	return PATH_SLIME

func _segunda_ronda():
	var n = rng.randi_range(1, 6)
	if n < 5:
		return PATH_SLIME
	else:
		return PATH_GINFECTED

func _tercera_ronda():
	var n = rng.randi_range(1, 6)
	if n < 3:
		return PATH_SLIME
	else:
		return PATH_GINFECTED

func _cuarta_ronda():
	var n = rng.randi_range(1, 6)
	if n < 3:
		return PATH_SLIME
	elif n < 6:
		return PATH_GINFECTED
	else:
		return PATH_GSPEAR


func _quinta_ronda():
	var n = rng.randi_range(1, 6)
	if n == 1:
		return PATH_SLIME
	elif n < 4:
		return PATH_GINFECTED
	else:
		return PATH_GSPEAR


func _sexta_ronda():
	var n = rng.randi_range(1, 6)
	if n == 1:
		return _tercera_ronda()
	elif n < 4:
		return PATH_GSPEAR
	else:
		return PATH_GSWORD


func _septima_ronda():
	var n = rng.randi_range(1, 6)
	if n == 1:
		return _cuarta_ronda()
	elif n < 3:
		return PATH_GSPEAR
	else:
		return PATH_GSWORD

func _octava_ronda():
	var n = rng.randi_range(1, 6)
	if n < 3:
		return PATH_GSPEAR
	else:
		return PATH_GSWORD

func _novena_ronda():
	var n = rng.randi_range(1, 12)
	if n < 12:
		return _octava_ronda()
	else:
		return PATH_GOLEM


func _decima_ronda():
	var n = rng.randi_range(1, 6)
	if n <= 3:
		return _octava_ronda()
	elif n == 4:
		return PATH_GOLEM
	else:
		return PATH_MAGE

var array_callable : Array

func _init():
	array_callable = [
		Callable(self, RONDA1),
		Callable(self, RONDA2),
		Callable(self, RONDA3),
		Callable(self, RONDA4),
		Callable(self, RONDA5),
		Callable(self, RONDA6),
		Callable(self, RONDA7),
		Callable(self, RONDA8),
		Callable(self, RONDA9),
		Callable(self, RONDA10)
	]

func instanciar_enemigo(ronda : int):
	return FactoryEnemy.instanciar_enemigo_por_path(array_callable[ronda].call())
	
