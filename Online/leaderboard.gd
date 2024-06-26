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
	http_request.request(url, headers, HTTPClient.METHOD_GET)


func _sort_dict_descendiente(a, b):
	if(a["score"] > b["score"]):
		return true
	return false


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	listado_player = json.data
	listado_player.sort_custom(_sort_dict_descendiente)
	_crear_tabla()
	
var path_score_label = "res://Online/scorelabel.tscn"
var paleta_color_pos = [[0,255,255],[0,3*255/4,255],[0,255/2,255]]
func _crear_tabla():
	var tabla = $ScrollContainer/VBoxContainer
	var i = 1
	print(listado_player.size())
	for player in listado_player:
		var player_label = load(path_score_label).instantiate()
		_rellenar_label(player_label, i)
		tabla.add_child(player_label)
		player_label.set_text_pos( "[center]#" + str(i) + "[/center]")
		player_label.set_text_name("[left]" + player["playerName"] + "[/left]")
		player_label.set_text_score("[center]" + str(player["score"]) + "[/center]")
		i += 1
		print(i)
	
func _rellenar_label(label, pos):
	if pos <= 3:
		label.get_node("PLabel").set_self_modulate(Color8(paleta_color_pos[pos-1][0], paleta_color_pos[pos-1][1], paleta_color_pos[pos-1][2]))
#Color(paleta_color_pos[pos-1][0], paleta_color_pos[pos-1][1], paleta_color_pos[pos-1][2])

var menu = "res://Menu/menu.tscn"
func _on_button_pressed():
	Global.goto_scene(menu)
