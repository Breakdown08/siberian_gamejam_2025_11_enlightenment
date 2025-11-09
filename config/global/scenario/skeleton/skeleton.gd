class_name ScenarioSkeleton extends Node

@export var test:ScenarioSkeletonAction

var cursor:ScenarioSkeletonAction = null


func start() -> void:
	Scenario.next_action.connect(_on_next_action)
	_init_cursor()
	_on_next_action(cursor)


func _input(event:InputEvent):
	if Input.is_action_just_pressed("ui_accept"):
		_on_next_action(cursor)


func _init_cursor():
	if not test == null:
		cursor = test
		prints("WARNING: TEST SCENARIO MODE STARTED AT NODE %s" % cursor.name)
		return
	cursor = get_children()[0] as ScenarioSkeletonAction if get_child_count() > 0 else null


func _on_next_action(next_cursor:ScenarioSkeletonAction):
	if next_cursor != null:
		cursor = next_cursor
		cursor.play()
		if cursor.wait_for_player:
			Scenario.cutscene_finished.emit()
	else:
		prints("тупик сценария...")
