class_name EventCreator extends ScenarioSkeletonAction

@export var events:Array[ScenarioEvent]


func _execute():
	for i in range(events.size()):
		if events[i] is ScenarioEvent:
			Scenario.create_event(events[i])
	executed.emit()
