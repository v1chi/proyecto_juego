extends Control


var url = "https://ucn-game-server.martux.cl/scores"
var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI0MjNkN2VjZi03MTg1LTRhNmMtOTNlMy0xZjk0MzY4YmFhMGMiLCJrZXkiOiIyeUExYXJnZDVycVRmMHhZb0xvcU4xMUNrIiwiaWF0IjoxNzE5NDYxNTMzLCJleHAiOjE3NTA5OTc1MzN9.7Ox7Ii-QmFeYQIvzcq6KMQnIWILoYvTJbBVVE1dHgR4"
var headers = ["Content-Type: application/json","Authorization: Bearer %s" % token] 

var http_request
var regex : RegEx = RegEx.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	http_request = $OK/HTTPRequest
	$OK.set_disabled(true)
	http_request.request_completed.connect(self._on_request_completed)
	
	regex.compile("\\W+")


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)
	

func _on_ok_button_up():
	var data = { "playerName": $nombre.text, "score": int($puntuacion.text) }
	var query = JSON.stringify(data)
	http_request.request(url, headers, HTTPClient.METHOD_POST, query)


func _on_nombre_focus_exited():
	var nombre = $nombre.text
	if !_es_nombre_valido(nombre):
		$nombre/NombreInvalido.set_visible(true)
		$OK.set_disabled(true)
	else:
		$nombre/NombreInvalido.set_visible(false)
		$OK.set_disabled(false)

func _es_nombre_valido(nombre : String):
	if nombre.length() > 10:
		return false
	elif regex.search_all(nombre).size() != 0:
		return false
	return true
