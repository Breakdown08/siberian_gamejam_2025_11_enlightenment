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

var code_selected:String = ""


func _ready() -> void:
	room.pressed.connect(func(): GameManager.back_to_room.emit())
	response = Scenario.database.get_key("radio_response_success").split(" ")
	unique_response = Utils.get_unique_array(response)
	init_chars()
	init_secret()
	if GameManager.game:
		var diary:DiaryInteractiveItem = GameManager.game.get_interactive_item(Game.INTERACTIVE_ITEM.DIARY)
		if diary.morse_code_textbook.is_translated:
			for undefined in password.get_children():
				undefined.char_node.text = find_symbol_by_code(undefined.code_node.text)
				undefined.code_node.hide()


func init_chars():
	for _char in TABLE.keys():
		var instance = CHAR.instantiate() as MorseCodeTextBookChar
		instance.selected.connect(on_selected)
		instance.book = self
		database.add_child(instance)
		var code:String = TABLE[_char]
		var symbol:String = _char
		instance.set_char(code, symbol)


func init_secret():
	for key in response:
		var instance = UNDEFINED.instantiate() as MorseCodeTextBookUndefined
		password.add_child(instance)
		instance.book = self
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
	if GameManager.game:
		var diary:DiaryInteractiveItem = GameManager.game.get_interactive_item(Game.INTERACTIVE_ITEM.DIARY)
		if not diary.morse_code_textbook.is_translated:
			secret_id += 1
			if secret_id == password.get_child_count():
				diary.morse_code_textbook.is_translated = true
				diary.check_act_2_conditions()
