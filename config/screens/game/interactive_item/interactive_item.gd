class_name InteractiveItem extends Control

@onready var audio_focused:AudioStreamPlayer = $audio_focused
@onready var audio_pressed:AudioStreamPlayer = $audio_pressed
@onready var button:Button = $button

@export var color_focused:Color = Color.AQUA
@export var scene:Game.SCENE

var is_locked:bool = true
var thoughts:Array = []
var thought_id:int = -1

signal new_thought(speech:String)


func _init() -> void:
	ready.connect(_base_ready)


func _base_ready() -> void:
	modulate = Color.WHITE
	thoughts = Thoughts.ABOUT_ITEMS[GameManager.scenario_stage][scene]
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button.pressed.connect(_on_button_pressed)
	new_thought.connect(on_new_thought)


func _on_mouse_entered() -> void:
	if GameManager.is_cutscene:
		return
	modulate = color_focused
	audio_focused.play()


func _on_mouse_exited() -> void:
	modulate = Color.WHITE
	audio_focused.stop()


func _on_button_pressed() -> void:
	if GameManager.is_cutscene:
		return
	audio_pressed.play()
	if is_locked:
		think_about()
		return
	EventBus.scene_switched.emit(scene)


func think_about():
	if thought_id < thoughts.size() - 1:
		thought_id += 1
	else:
		thought_id = 0
	var actor_speech:String = thoughts[thought_id]
	new_thought.emit(actor_speech)
	EventBus.thought.emit(actor_speech)


func on_new_thought(speech:String): # override
	pass
