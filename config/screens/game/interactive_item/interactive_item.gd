extends Control

@export var color_focused:Color = Color.RED
@export var scene:Game.SCENE

var is_locked:bool = true
var thoughts:Array = []
var thought_id:int = -1


func _ready() -> void:
	modulate = Color.WHITE
	thoughts = Thoughts.ABOUT_ITEMS[GameManager.scenario_stage][scene]


func _on_mouse_entered() -> void:
	modulate = color_focused


func _on_mouse_exited() -> void:
	modulate = Color.WHITE


func _on_button_pressed() -> void:
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
	EventBus.thought.emit(actor_speech)
