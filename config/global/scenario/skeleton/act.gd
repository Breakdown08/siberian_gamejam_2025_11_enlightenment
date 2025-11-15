class_name Act extends ScenarioSkeletonAction

@export var number:int = 1


func _execute():
	Scenario.act_started.emit(self)
	executed.emit()
