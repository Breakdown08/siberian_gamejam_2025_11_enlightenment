extends Control

@onready var room:Button = $system_panel/margin/room


func _ready() -> void:
	room.pressed.connect(_on_room_pressed)
	Scenario.final_scene.connect(_on_room_pressed)
	GameManager.scenario_next()


func _on_room_pressed():
	EventBus.scene_switched.emit(Game.SCENE.MAIN)
