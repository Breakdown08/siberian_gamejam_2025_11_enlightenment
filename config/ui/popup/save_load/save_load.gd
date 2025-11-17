class_name SaveLoad extends Control

@onready var new_save:HBoxContainer = $panel/margin/body/new_save
@onready var button_delete:Button = $panel/margin/body/buttons/delete
@onready var button_load:Button = $panel/margin/body/buttons/load
@onready var button_exit:Button = $panel/margin/body/buttons/exit
@onready var button_save:Button = $panel/margin/body/new_save/button
@onready var list:VBoxContainer = $panel/margin/body/saves/scroll/margin/list

const SAVE_PATH:String = "user://saves.json"
const SAVE:PackedScene = preload("res://config/ui/popup/save_load/save/save.tscn")

enum MODE{SAVE,LOAD}
var mode:MODE = MODE.SAVE


func _ready() -> void:
	button_exit.pressed.connect(queue_free)
	button_save.pressed.connect(GameManager.game_save)
	button_load.disabled = true
	button_delete.disabled = true
	_match_mode()
	var data:String = pull()
	if not data.is_empty():
		var parsed_data:Array = JSON.parse_string(data)
		for save_data in parsed_data:
			var save:SaveLoadItem = SAVE.instantiate()
			save.timestamp = save_data.get(str(GameManager.SAVE_KEYS.TIMESTAMP))
			list.add_child(save)


static func pull() -> String:
	var data:String = ""
	var file:FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		data = file.get_as_text()
		file.close()
	return data


static func push(data) -> Error:
	var success:bool = false
	var file:FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	success = file.store_string(JSON.stringify(data, '\t'))
	file.close()
	return Error.OK if success else Error.FAILED


func _match_mode():
	match mode:
		MODE.SAVE:
			button_load.hide()
		MODE.LOAD:
			new_save.hide()
			button_delete.hide()
