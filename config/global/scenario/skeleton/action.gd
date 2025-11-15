@abstract class_name ScenarioSkeletonAction extends Node

@export var out:ScenarioSkeletonAction = null
@export var wait_for_player:bool = false

signal executed


func _init() -> void:
	executed.connect(_debug_info)
	executed.connect(_on_executed)


func play():
	if not wait_for_player:
		Scenario.is_stopped = false
		execute()
		return
	Scenario.is_stopped = true


func execute():
	_execute()


func _debug_info():
	var tab:String = ""
	if self is Act:
		tab = ""
	elif self is Cutscene:
		tab = "	"
	elif self is ActorSpeech:
		tab = "		"
	elif self is EventCreator:
		tab = "		"
	prints(tab + "[SCENARIO] action by %s executed" % self.name)


func _on_executed():
	var next_cursor:ScenarioSkeletonAction = null
	if out:
		next_cursor = out
		_to_next_cursor(next_cursor)
		return
	if get_child_count() > 0:
		next_cursor = get_children()[0] as ScenarioSkeletonAction
		_to_next_cursor(next_cursor)
		return
	else:
		if get_parent() is ScenarioSkeletonAction and get_index() < get_parent().get_child_count() - 1:
			next_cursor = get_parent().get_children()[get_index() + 1] as ScenarioSkeletonAction
			_to_next_cursor(next_cursor)
			return
	_to_next_cursor(next_cursor)


func _to_next_cursor(next_cursor:ScenarioSkeletonAction):
	Scenario.next_action.emit(next_cursor)


@abstract func _execute() # override
