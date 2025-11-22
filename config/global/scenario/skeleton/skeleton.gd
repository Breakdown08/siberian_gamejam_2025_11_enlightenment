class_name ScenarioSkeleton extends Node

@export var test:ScenarioSkeletonAction

var cursor:ScenarioSkeletonAction = null


func _ready() -> void:
	Scenario.reading_finished.connect(func():
		on_next_action(cursor)
	)
	Scenario.next_action.connect(on_next_action)


func start() -> void:
	_init_cursor()
	on_next_action(cursor)


func _init_cursor():
	if not test == null:
		Scenario.cutscene_started.emit()
		cursor = test
		prints("WARNING: TEST SCENARIO MODE STARTED AT NODE %s" % cursor.name)
		return
	cursor = get_children()[0] as ScenarioSkeletonAction if get_child_count() > 0 else null


func on_next_action(next_cursor:ScenarioSkeletonAction):
	if next_cursor != null:
		cursor = next_cursor
		if cursor.wait_for_player:
			Scenario.cutscene_finished.emit()
		cursor.play()
	else:
		push_warning("Scenario is locked")
