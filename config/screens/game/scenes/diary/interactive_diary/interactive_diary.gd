class_name DiaryInteractiveItem extends InteractiveItem

@export var oscilloscope:OscilloscopeInteractiveItem
@export var computer:ComputerInteractiveItem

var oscilloscope_params:String = ""
var notes:Array[String] = []


func _ready() -> void:
	Scenario.event.connect(_on_scenario_event)
	oscilloscope.params_updated.connect(_on_oscilloscope_params_updated)


func _on_scenario_event(key:String, value:String):
	if key == "diary_note":
		notes.append(value)


func _on_oscilloscope_params_updated(new_params:TextureRect):
	oscilloscope_params = str(new_params.name.hash())
