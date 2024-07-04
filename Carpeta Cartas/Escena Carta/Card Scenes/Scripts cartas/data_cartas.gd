class_name DataCartas
extends Node


var array_script : Array

func _init():
	
	array_script = [
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta1.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta2.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta3.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta4.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta5.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta6.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta7.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta8.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta9.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta10.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta11.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta12.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta13.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta14.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta15.gd",
	"res://Carpeta Cartas/Escena Carta/Card Scenes/Scripts cartas/Carta16.gd"
	]

	


	
func get_size():
	return array_script.size()

func get_script_carta(index):
	if index > array_script.size() or index < 0:
		return null
	return array_script[index]

func remove_script_carta(index):
	array_script.remove_at(index)
