class_name Saves extends Control

@onready var new_save:HBoxContainer = $panel/margin/body/new_save
@onready var delete:Button = $panel/margin/body/buttons/delete
@onready var load:Button = $panel/margin/body/buttons/load
@onready var exit:Button = $panel/margin/body/buttons/exit

const SAVE_PATH:String = "user://saves.json"

var hide_save_button:bool = false


func _ready() -> void:
	exit.pressed.connect(queue_free)
	if hide_save_button:
		new_save.hide()
		delete.hide()
	else:
		load.hide()
	pull()


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
	success = file.store_string(JSON.stringify(data, '\n'))
	file.close()
	return Error.OK if success else Error.FAILED
