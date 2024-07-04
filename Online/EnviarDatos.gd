extends Control

const PUNTAJE_MAX : int = 999999999
const PUNTAJE_MIN : int = 1
var url = "https://ucn-game-server.martux.cl/scores"
var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI0MjNkN2VjZi03MTg1LTRhNmMtOTNlMy0xZjk0MzY4YmFhMGMiLCJrZXkiOiIyeUExYXJnZDVycVRmMHhZb0xvcU4xMUNrIiwiaWF0IjoxNzE5NDYxNTMzLCJleHAiOjE3NTA5OTc1MzN9.7Ox7Ii-QmFeYQIvzcq6KMQnIWILoYvTJbBVVE1dHgR4"
var headers = ["Content-Type: application/json","Authorization: Bearer %s" % token] 
var http_request
var regex : RegEx = RegEx.new()

var menu = "res://Menu/menu.tscn"
var leaderboard = "res://Online/Leaderboard.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = not get_tree().paused
	http_request = $OK/HTTPRequest
	$OK.set_disabled(true)
	set_process_input(true) 
	http_request.request_completed.connect(self._on_request_completed)
	regex.compile("[^A-Za-z0-9]")


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)
	get_tree().paused = not get_tree().paused
	Global.goto_scene(leaderboard)
	

func _validar_puntuacion():
	if Global.score > PUNTAJE_MAX: # 999.999.999
		Global.score = PUNTAJE_MAX
		
	if Global.score < PUNTAJE_MIN: # 1
		Global.score = PUNTAJE_MIN





func _on_ok_button_up():
	_validar_puntuacion()
	var data = { "playerName": $nombre.text, "score": int(Global.score) }
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
	if nombre == null or nombre == "":
		return false 
	if nombre.length() > 10:
		return false
	elif regex.search_all(nombre).size() != 0:
		return false
	return true


func _input(ev):
	if Input.is_key_pressed(KEY_ENTER) and _es_nombre_valido($nombre.text):
		$OK.emit_signal("button_up")
	










func _on_texture_button_button_up():
	Global.goto_scene(menu)
