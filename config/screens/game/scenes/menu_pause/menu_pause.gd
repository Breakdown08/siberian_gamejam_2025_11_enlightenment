extends Control

@onready var button_main_menu:Button = $panel/margin/list/main_menu
@onready var button_continue:Button = $panel/margin/list/continue


func _ready() -> void:
	button_continue.pressed.connect(on_button_continue_pressed)
	button_main_menu.pressed.connect(on_button_main_menu_pressed)


func on_button_continue_pressed():
	queue_free()


func on_button_main_menu_pressed():
	EventBus.screen_switched.emit(Main.SCREEN.MAIN_MENU)
