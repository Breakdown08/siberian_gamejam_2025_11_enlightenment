extends Control

@onready var room:Button = $system_panel/margin/room
@onready var list:Control = $list
@onready var oscilloscope_params:DiaryItem = $list/oscilloscope_params
@onready var radio_response:DiaryItem = $list/radio_response


func _ready() -> void:
	room.pressed.connect(_on_room_pressed)
	clear()
	get_oscilloscope_params_from_diary()


func _on_room_pressed():
	EventBus.scene_switched.emit(Game.SCENE.MAIN)


func get_oscilloscope_params_from_diary():
	if GameManager.oscilloscope_params.is_empty():
		return
	oscilloscope_params.show()
	oscilloscope_params.write_value(GameManager.oscilloscope_params)


func clear():
	for item in list.get_children():
		item.hide()
