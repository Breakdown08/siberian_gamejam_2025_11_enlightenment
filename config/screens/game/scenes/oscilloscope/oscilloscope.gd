extends Control

@onready var room:Button = $system_panel/margin/room


func _ready() -> void:
	room.pressed.connect(_on_room_pressed)


func _on_cheat_button_pressed() -> void:
	Scenario.oscilloscope_write_params.emit(PackedInt32Array([1, 2, 3, 4]))
	EventBus.notification.emit(Scenario.NOTIFICATION_UPDATE_DIARY)


func _on_room_pressed():
	EventBus.scene_switched.emit(Game.SCENE.MAIN)
