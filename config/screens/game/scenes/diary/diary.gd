extends Control

@onready var room:Button = $system_panel/margin/room
@onready var list:Control = $list
@onready var oscilloscope_params:DiaryItem = $list/oscilloscope_params
@onready var radio_response:DiaryItem = $list/radio_response


func _ready() -> void:
	for item in $hints_scene_1.get_children():
		item.hide()
	room.pressed.connect(_on_room_pressed)
	clear()
	get_oscilloscope_params_from_diary()
	$hints_scene_1/shch.visible = true if GameManager.is_diary_unlocked else false
	$hints_scene_1/radio_success_response.visible = true if GameManager.is_radio_success_response else false
	$hints_scene_1/photo.visible = true if GameManager.is_photo_turned else false
	$hints_scene_1/glasses.visible = true if GameManager.is_remeber_for_glasses else false


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
