class_name Game extends Control

@onready var system_panel:Panel = $system_panel
@onready var button_menu:Button = $system_panel/margin/menu
@onready var scene:Node = $scene

enum SCENE {
	MAIN, 
	MENU_PAUSE, 
	COMPUTER, 
	DIARY, 
	ENCRYPTION_MACHINE, 
	GLASSES, 
	MORSE_CODE_TEXTBOOK, 
	OSCILLOSCOPE, 
	PHOTO
}

var SCENES:Dictionary[SCENE, PackedScene] = {
	SCENE.MENU_PAUSE : preload("res://config/screens/game/config/menu_pause/menu_pause.tscn"),
	SCENE.COMPUTER : preload("res://config/screens/game/scenes/computer/computer.tscn"),
	SCENE.DIARY : preload("res://config/screens/game/scenes/diary/diary.tscn"),
	SCENE.ENCRYPTION_MACHINE : preload("res://config/screens/game/scenes/encryption_machine/encryption_machine.tscn"),
	SCENE.GLASSES : preload("res://config/screens/game/scenes/glasses/glasses.tscn"),
	SCENE.MORSE_CODE_TEXTBOOK : preload("res://config/screens/game/scenes/morse_code_textbook/morse_code_textbook.tscn"),
	SCENE.OSCILLOSCOPE : preload("res://config/screens/game/scenes/oscilloscope/oscilloscope.tscn"),
	SCENE.PHOTO : preload("res://config/screens/game/scenes/photo/photo.tscn"),
}


func _ready() -> void:
	button_menu.pressed.connect(on_button_menu_pressed)
	EventBus.scene_switched.connect(on_scene_switched)


func on_button_menu_pressed():
	add_child(SCENES[SCENE.MENU_PAUSE].instantiate())


func on_scene_switched(next_scene:SCENE):
	for child in scene.get_children():
		child.queue_free()
	if next_scene == SCENE.MAIN:
		return
	scene.add_child(SCENES[next_scene].instantiate())
