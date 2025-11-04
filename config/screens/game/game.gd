class_name Game extends Control

@onready var system_panel:Panel = $system_panel
@onready var button_menu:Button = $system_panel/margin/menu
@onready var scene:Node = $scene
@onready var notifications:Control = $notifications
@onready var game_over:TextureRect = $game_over

const NOTIFICATION:PackedScene = preload("res://config/ui/popup/notification/notification.tscn")

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
	SCENE.MENU_PAUSE : preload("res://config/screens/game/scenes/menu_pause/menu_pause.tscn"),
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
	EventBus.notification.connect(on_notification)
	Scenario.game_over.connect(on_game_over)
	EventBus.game_started.emit()
	Scenario.final_scene.connect(func():
		$final.show()
		$static_background.hide()
		$hero.hide()
		$friend.hide()
		$interactive_items.hide()
		$window.hide()
	)


func on_button_menu_pressed():
	add_child(SCENES[SCENE.MENU_PAUSE].instantiate())


func on_scene_switched(next_scene:SCENE):
	for child in scene.get_children():
		child.queue_free()
	if next_scene == SCENE.MAIN:
		return
	scene.add_child(SCENES[next_scene].instantiate())


func on_notification(message:String):
	var instance = NOTIFICATION.instantiate() as Notification
	notifications.add_child(instance)
	instance.message.text = message


func on_game_over():
	game_over.show()
	var tween:Tween = Utils.tween(self)
	tween.tween_property(game_over, "modulate", Color.WHITE, 2.0)
	
