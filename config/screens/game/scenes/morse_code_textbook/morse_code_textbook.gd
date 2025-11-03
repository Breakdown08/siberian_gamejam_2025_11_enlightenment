extends Control

@onready var room:Button = $system_panel/margin/room


func _ready() -> void:
	room.pressed.connect(_on_room_pressed)


func _on_room_pressed():
	EventBus.scene_switched.emit(Game.SCENE.MAIN)
