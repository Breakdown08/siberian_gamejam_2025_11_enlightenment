extends Control

@onready var room:Button = $system_panel/margin/room


func _ready() -> void:
	room.pressed.connect(_on_room_pressed)


func _on_cheat_button_pressed() -> void:
	write_params()
	update_diary()


func _on_room_pressed():
	EventBus.scene_switched.emit(Game.SCENE.MAIN)


func update_diary():
	EventBus.notification.emit(Scenario.NOTIFICATION_UPDATE_DIARY)


func write_params():
	Scenario.oscilloscope_write_params.emit(str([1, 2, 3, 4]))
