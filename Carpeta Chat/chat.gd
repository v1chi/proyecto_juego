extends Node2D



@onready var host = $Host
@onready var join = $Join
@onready var username = $Username
@onready var send = $Send
@onready var message = $Message
@onready var messages = $Messages

var usrnm : String
var msg : String 




func _on_host_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(1027)
	get_tree().set_multiplayer(SceneMultiplayer.new(), self.get_path())
	multiplayer.multiplayer_peer = peer
	joined()



func _on_join_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1", 1027)
	get_tree().set_multiplayer(SceneMultiplayer.new(), self.get_path())
	multiplayer.multiplayer_peer = peer
	joined()
	pass
	

func joined():
	host.hide()
	join.hide()
	username.hide()
	usrnm = username.text

func _on_send_pressed():
	rpc("msg_rpc", usrnm, message.text)
	message.text = ""

@rpc("any_peer", "call_local")
func msg_rpc(usrnm, data):
	messages.text += str(usrnm, ": ", data, "\n")
	messages.scroll_vertical = INF




