class_name MorseCodeTextBook extends Control

@onready var room:Button = $system_panel/margin/room
@onready var database:GridContainer = $database
@onready var password:GridContainer = $password

const CHAR:PackedScene = preload("res://config/screens/game/scenes/morse_code_textbook/char/char.tscn")
const UNDEFINED:PackedScene = preload("res://config/screens/game/scenes/morse_code_textbook/undefined/undefined.tscn")

const TABLE:Dictionary[String, String] = {
	"А" : "•−",
	"Б" : "−•••",
	"В" : "•−−",
	"Г" : "−−•",
	"Д" : "−••",
	"Е" : "−••",
	"Ж" : "•••−",
	"З" : "−−••",
	"И" : "••",
	"Й" : "•−−−",
	"К" : "−•−",
	"Л" : "•−••",
	"М" : "−−",
	"H" : "−•",
	"О" : "−−−",
	"П" : "•−−•",
	"P" : "•−•",
	"С" : "•••",
	"Т" : "−",
	"У" : "••−",
	"Ф" : "••−•",
	"Х" : "••••",
	"Ц" : "−•−•",
	"Ч" : "−−−•",
	"Ш" : "−−−−",
	"Щ" : "−−•−",
	"Ъ" : "•−−•−•",
	"Ь" : "−••−",
	"Ы" : "−•−−",
	"Э" : "••−••",
	"Ю" : "••−−",
	"Я" : "•−•−",
	"." : "••••••",
	"," : "•−•−•−",
	"_" : "????"
}

var response:Array
var unique_response:Array

var secret_id:int = 0


func _ready() -> void:
	room.pressed.connect(_on_room_pressed)
	response = Scenario.RADIO_RESPONSE.split(" ")
	unique_response = Utils.get_unique_array(response)
	init_chars()
	init_secret()
	Scenario.back_to_room.connect(_on_room_pressed)


func _on_room_pressed():
	EventBus.scene_switched.emit(Game.SCENE.MAIN)


func init_chars():
	for _char in TABLE.keys():
		var instance = CHAR.instantiate() as MorseCodeTextBookChar
		instance.selected.connect(on_selected)
		database.add_child(instance)
		var code:String = TABLE[_char]
		var symbol:String = _char
		instance.set_char(code, symbol)


func init_secret():
	for key in response:
		var instance = UNDEFINED.instantiate() as MorseCodeTextBookUndefined
		password.add_child(instance)
		instance.code_node.text = key
		instance.unsecret.connect(on_unsecret)


func on_selected(target:MorseCodeTextBookChar):
	for item in database.get_children():
		if item == target:
			item.modulate = Color.RED
		else:
			item.is_selected = false
			item.modulate = MorseCodeTextBookChar.COLOR_DEFAULT


static func find_symbol_by_code(code:String) -> String:
	for symbol in TABLE.keys():
		if TABLE[symbol] == code:
			return symbol
	return "none"


func on_unsecret():
	if !GameManager.is_morse_translated:
		secret_id += 1
		if secret_id == password.get_child_count():
			Scenario.morse_translated.emit()
			GameManager.scenario_next()
		
