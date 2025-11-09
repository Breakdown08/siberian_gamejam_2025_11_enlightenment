extends Control

@onready var room:Button = $system_panel/margin/room


func _ready() -> void:
	room.pressed.connect(func(): GameManager.back_to_room.emit())
	#Scenario.final_scene.connect(_on_room_pressed)
	GameManager.scenario_next.emit()
