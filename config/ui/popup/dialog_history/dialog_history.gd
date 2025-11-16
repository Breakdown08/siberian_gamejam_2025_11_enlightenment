extends Control

@onready var room:Button = $system_panel/margin/room
@onready var list_info:VBoxContainer = $panel/margin/scroll/box

const INFO:PackedScene = preload("res://config/ui/popup/dialog_history/info/info.tscn")


func _ready() -> void:
	for action in Scenario.history:
		var info:Label = INFO.instantiate()
		info.text = action
		list_info.add_child(info)
	room.pressed.connect(queue_free)
