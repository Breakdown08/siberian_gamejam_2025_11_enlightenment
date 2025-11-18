class_name Game extends Node

@onready var system_panel:Panel = $system_panel
@onready var button_menu:Button = $system_panel/margin/menu
@onready var button_dialog_history:Button = $system_panel/margin/dialog_history
@onready var scene:Node = $scene
@onready var notifications:Control = $notifications
@onready var game_over:TextureRect = $game_over

const NOTIFICATION:PackedScene = preload("res://config/ui/popup/notification/notification.tscn")
const MENU_PAUSE:PackedScene = preload("res://config/screens/game/scenes/menu_pause/menu_pause.tscn")
const DIALOG_HISTORY:PackedScene = preload("res://config/ui/popup/dialog_history/dialog_history.tscn")

enum INTERACTIVE_ITEM {
	COMPUTER,
	DIARY,
	ENCRYPTION_MACHINE,
	GLASSES,
	MORSE_CODE_TEXTBOOK,
	OSCILLOSCOPE,
	PHOTO
}

const INTERACTIVE_ITEMS:Dictionary[INTERACTIVE_ITEM, PackedScene] = {
	INTERACTIVE_ITEM.COMPUTER : preload("res://config/screens/game/scenes/computer/computer.tscn"),
	INTERACTIVE_ITEM.DIARY : preload("res://config/screens/game/scenes/diary/diary.tscn"),
	INTERACTIVE_ITEM.ENCRYPTION_MACHINE : preload("res://config/screens/game/scenes/encryption_machine/encryption_machine.tscn"),
	INTERACTIVE_ITEM.GLASSES : preload("res://config/screens/game/scenes/glasses/glasses.tscn"),
	INTERACTIVE_ITEM.MORSE_CODE_TEXTBOOK : preload("res://config/screens/game/scenes/morse_code_textbook/morse_code_textbook.tscn"),
	INTERACTIVE_ITEM.OSCILLOSCOPE : preload("res://config/screens/game/scenes/oscilloscope/oscilloscope.tscn"),
	INTERACTIVE_ITEM.PHOTO : preload("res://config/screens/game/scenes/photo/photo.tscn"),
}

@export var interactive_items:Dictionary[INTERACTIVE_ITEM, InteractiveItem]


func _ready() -> void:
	button_menu.pressed.connect(func(): add_child(MENU_PAUSE.instantiate()))
	button_dialog_history.pressed.connect(func(): add_child(DIALOG_HISTORY.instantiate()))
	GameManager.interactive_item_opened.connect(on_interactive_item_opened)
	#Scenario.game_over.connect(on_game_over)
	GameManager.game_started.emit(self)
	GameManager.back_to_room.connect(on_back_to_room)
	#Scenario.final_scene.connect(func():
		#$final.show()
		#$static_background.hide()
		#$hero.hide()
		#$friend.hide()
		#$interactive_items.hide()
		#$window.hide()
	#)


func on_back_to_room():
	for child in scene.get_children():
		child.queue_free()


func on_interactive_item_opened(target:INTERACTIVE_ITEM):
	for child in scene.get_children():
		child.queue_free()
	if target == null: return
	scene.add_child(INTERACTIVE_ITEMS[target].instantiate())


func on_notification(message:String):
	var instance = NOTIFICATION.instantiate() as Notification
	notifications.add_child(instance)
	instance.message.text = message


func on_game_over():
	game_over.show()
	var tween:Tween = Utils.tween(self)
	tween.tween_property(game_over, "modulate", Color.WHITE, 2.0)


func get_interactive_item(interactive_item:INTERACTIVE_ITEM) -> InteractiveItem:
	return interactive_items[interactive_item]
