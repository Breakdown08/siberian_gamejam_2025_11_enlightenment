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

var selected_id:int = -1


func _ready() -> void:
	GameManager.game_saved.connect(_update_list)
	GameManager.game_deleted.connect(_update_list)
	button_exit.pressed.connect(queue_free)
	button_save.pressed.connect(GameManager.game_save)
	button_load.pressed.connect(_on_button_load_pressed)
	button_delete.pressed.connect(_on_button_delete_pressed)
	_match_mode()
	_update_list()


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


func _update_list():
	for item in list.get_children():
		item.free()
	selected_id = -1
	button_load.disabled = true
	button_delete.disabled = true
	var data:String = pull()
	if not data.is_empty():
		var parsed_data:Array = JSON.parse_string(data)
		for save_data in parsed_data:
			_create_save_item(save_data)


func _create_save_item(save_data:Dictionary):
	var save:SaveLoadItem = SAVE.instantiate()
	save.timestamp = save_data.get(str(GameManager.SAVE_KEYS.TIMESTAMP))
	save.selected.connect(_on_save_item_selected)
	save.action = str(save_data.get(str(GameManager.SAVE_KEYS.ACT))).to_int()
	list.add_child(save)


func _on_save_item_selected(id:int):
	selected_id = id
	button_load.disabled = false
	button_delete.disabled = false


func _on_button_load_pressed():
	GameManager.game_load(selected_id)
	queue_free()


func _on_button_delete_pressed():
	GameManager.game_delete(selected_id)
