extends Control

@onready var system_panel:Panel = $system_panel
@onready var button_menu:Button = $system_panel/margin/menu

const MENU_PAUSE:PackedScene = preload("res://config/screens/game/config/menu_pause/menu_pause.tscn")


func _ready() -> void:
	button_menu.pressed.connect(on_button_menu_pressed)


func on_button_menu_pressed():
	add_child(MENU_PAUSE.instantiate())
