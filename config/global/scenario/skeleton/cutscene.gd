class_name Cutscene extends ScenarioSkeletonAction


func _execute():
	Scenario.cutscene_started.emit()
	executed.emit()
