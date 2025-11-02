extends Control

@export var color_focused:Color = Color.RED


func _ready() -> void:
	modulate = Color.WHITE


func _on_mouse_entered() -> void:
	modulate = color_focused


func _on_mouse_exited() -> void:
	modulate = Color.WHITE
