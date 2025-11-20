class_name Main extends Control

@onready var screen:Node = $screen

enum SCREEN {GAME, SETTINGS, MAIN_MENU}

const SCREENS:Dictionary[SCREEN, PackedScene] = {
	SCREEN.GAME : preload("res://config/screens/game/game.tscn"),
	SCREEN.SETTINGS : preload("res://config/screens/settings/settings.tscn"),
	SCREEN.MAIN_MENU : preload("res://config/screens/main_menu/main_menu.tscn"),
}


func _ready() -> void:
	EventBus.screen_switched.connect(on_screen_switched)
	EventBus.screen_switched.emit(SCREEN.MAIN_MENU)
	
	SoundManager.music_player = $music
	SoundManager.sfx_player = $sfx
	
	SoundManager.play_music()


func on_screen_switched(next_screen:SCREEN):
	for child in screen.get_children():
		child.queue_free()
	screen.add_child(SCREENS[next_screen].instantiate())
