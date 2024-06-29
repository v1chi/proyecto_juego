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
	

func _crear_tabla():
	var tabla = $ScrollContainer/ContenedorTabla
	var text_tabla = ""
	var i = 1
	for player in listado_player:
		text_tabla = text_tabla + str(i) + "- " + player["playerName"] + "																				" + "Score: " + str(player["score"]) + "\n"
		i += 1
	tabla.text = text_tabla

