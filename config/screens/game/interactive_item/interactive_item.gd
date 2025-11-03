extends Control

@export var color_focused:Color = Color.RED
@export var scene:Game.SCENE


func _ready() -> void:
	modulate = Color.WHITE


func _on_mouse_entered() -> void:
	modulate = color_focused


func _on_mouse_exited() -> void:
	modulate = Color.WHITE


func _on_button_pressed() -> void:
	EventBus.scene_switched.emit(scene)
