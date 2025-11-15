class_name DiaryInteractiveItem extends InteractiveItem

var notes:Array[String] = []


func _ready() -> void:
	Scenario.event.connect(on_scenario_event)


func on_scenario_event(key:String, value:String):
	if key == "diary_note":
		notes.append(value)
