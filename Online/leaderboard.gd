extends Control

var boton
var http_request : HTTPRequest

var url = "https://ucn-game-server.martux.cl/scores"
var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI0MjNkN2VjZi03MTg1LTRhNmMtOTNlMy0xZjk0MzY4YmFhMGMiLCJrZXkiOiIyeUExYXJnZDVycVRmMHhZb0xvcU4xMUNrIiwiaWF0IjoxNzE5NDYxNTMzLCJleHAiOjE3NTA5OTc1MzN9.7Ox7Ii-QmFeYQIvzcq6KMQnIWILoYvTJbBVVE1dHgR4"
var headers = ["Content-Type: application/json","Authorization: Bearer %s" % token] 
var listado_player : Array

func _ready():
	http_request = $HTTPRequest
	http_request.request_completed.connect(self._on_request_completed)
	print(url)
	http_request.request(url, headers, HTTPClient.METHOD_GET)


func _sort_dict_descendiente(a, b):
	if(a["score"] > b["score"]):
		return true
	return false


func _on_request_completed(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		var json = JSON.parse_string(body.get_string_from_utf8())
		listado_player = json.data
		listado_player.sort_custom(_sort_dict_descendiente)
		_crear_tabla()
	else:
		$AnimationPlayer.pause()
		$PanelContainer/RichTextLabel.text = "[center]Error al conectarse con el servidor...[/center]"
	
var path_score_label = "res://Online/scorelabel.tscn"
var paleta_color_pos = [[0,255,255],[0,3*255/4,255],[0,255/2,255]]
func _crear_tabla():
	var tabla = $ScrollContainer/VBoxContainer
	var i = 1
	for player in listado_player:
		var player_label = load(path_score_label).instantiate()
		_rellenar_label(player_label, i)
		tabla.add_child(player_label)
		player_label.set_text_pos( "[center]#" + str(i) + "[/center]")
		player_label.set_text_name("[left]" + player["playerName"] + "[/left]")
		player_label.set_text_score("[center]" + _get_formato_score(player["score"]) + "[/center]")
		i += 1

var array_theme = [
	"res://Carpeta Cartas/Escena Carta/posiciones/posicion_1.tres",
	"res://Carpeta Cartas/Escena Carta/posiciones/posicion_2.tres",
	"res://Carpeta Cartas/Escena Carta/posiciones/posicion_3.tres"
	]
func _rellenar_label(label, pos):
	label.get_node("PLabel").set_self_modulate(Color8(paleta_color_pos[2][0], paleta_color_pos[2][1], paleta_color_pos[2][2]))
	if pos <= 3:
		#label.get_node("PLabel").set_self_modulate(Color8(paleta_color_pos[pos-1][0], paleta_color_pos[pos-1][1], paleta_color_pos[pos-1][2]))
		label.get_node("PLabel/HBoxContainer/PPos").set_theme(load(array_theme[pos-1]))
#Color(paleta_color_pos[pos-1][0], paleta_color_pos[pos-1][1], paleta_color_pos[pos-1][2])

var menu = "res://Menu/menu.tscn"
func _on_button_pressed():
	Global.goto_scene(menu)

func _get_formato_score(score :int):
	#return str(score)
	var string_score = str(score)
	var score_con_delimitadores = ""
	var str = ""
	var cont = 1
	for i in range(string_score.length() - 1, -1, -1):
		score_con_delimitadores = score_con_delimitadores + string_score[i]
		if cont % 3 == 0 and i != 0:
			score_con_delimitadores = score_con_delimitadores + ","
		cont += 1
	for i in range(score_con_delimitadores.length() - 1, -1, -1):
		str += score_con_delimitadores[i]
	
	return str

