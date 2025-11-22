class_name InteractiveItem extends Control

@onready var audio_focused:AudioStreamPlayer = $audio_focused
@onready var audio_pressed:AudioStreamPlayer = $audio_pressed
@onready var button:Button = $button

@export var color_focused:Color = Color.AQUA
@export var interactive_item:Game.INTERACTIVE_ITEM

var is_locked:bool = true
var thoughts:Array = []
var thought_id:int = -1


func _init() -> void:
	ready.connect(_base_ready)


func _base_ready() -> void:
	modulate = Color.WHITE
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button.pressed.connect(_on_pressed)
	GameManager.items_availability_changed.connect(on_items_availability_changed)
	GameManager.items_info_changed.connect(on_items_info_changed)


func _on_mouse_entered() -> void:
	if GameManager.is_cutscene:
		return
	modulate = color_focused
	SoundManager.play_sfx(load(audio_focused.stream.resource_path))


func _on_mouse_exited() -> void:
	modulate = Color.WHITE
	audio_focused.stop()


func _on_pressed() -> void:
	if not GameManager.is_cutscene:
		SoundManager.play_sfx(load(audio_pressed.stream.resource_path))
		if thoughts.size() == 1 and thoughts[0] == "":
			thought_id = -1
		else:
			think_about()
		if thought_id == -1 and is_locked == false:
			GameManager.interactive_item_opened.emit(interactive_item)


func think_about():
	if thought_id < thoughts.size() - 1:
		thought_id += 1
	else:
		thought_id = -1
		return
	var speech:String = thoughts[thought_id]
	GameManager.item_info.emit(speech)


func on_items_info_changed(info:Dictionary[Game.INTERACTIVE_ITEM, Array]):
	thoughts = []
	thought_id = -1
	if info.has(interactive_item):
		thoughts = info[interactive_item]
	if thoughts.is_empty():
		thoughts.append(Scenario.database.get_key("not_interesting"))


func on_items_availability_changed(new_value:Dictionary[Game.INTERACTIVE_ITEM, bool]):
	is_locked = true
	if new_value.has(interactive_item):
		is_locked = !new_value[interactive_item]
