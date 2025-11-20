extends Control

@onready var button_main_menu:Button = $panel/margin/list/main_menu
@onready var button_continue:Button = $panel/margin/list/continue
@onready var button_save:Button = $panel/margin/list/save
@onready var button_load:Button = $panel/margin/list/load
@onready var button_settings:Button = $panel/margin/list/settings


func _ready() -> void:
	button_continue.pressed.connect(_on_button_continue_pressed)
	button_main_menu.pressed.connect(_on_button_main_menu_pressed)
	button_save.pressed.connect(_on_button_save_pressed)
	button_load.pressed.connect(_on_button_load_pressed)
	button_settings.pressed.connect(_on_button_settings_pressed)
	GameManager.game_loaded.connect(queue_free)


func _on_button_continue_pressed():
	queue_free()


func _on_button_main_menu_pressed():
	EventBus.screen_switched.emit(Main.SCREEN.MAIN_MENU)


func _on_button_save_pressed():
	var save_load = GameManager.SAVE_LOAD.instantiate()
	save_load.mode = SaveLoad.MODE.SAVE
	add_child(save_load)


func _on_button_load_pressed():
	var save_load = GameManager.SAVE_LOAD.instantiate()
	save_load.mode = SaveLoad.MODE.LOAD
	add_child(save_load)


func _on_button_settings_pressed():
	$panel.visible = false
	var settings = GameManager.SETTINGS.instantiate()
	add_child(settings)
