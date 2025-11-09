@abstract class_name ScenarioSkeletonAction extends Node

@export var out:ScenarioSkeletonAction = null
@export var wait_for_player:bool = false

signal executed


func _init() -> void:
	ready.connect(_base_ready)
	executed.connect(_debug_info)


func _base_ready():
	executed.connect(_on_executed)
	if wait_for_player:
		GameManager.scenario_next.connect(func():
			if Scenario.skeleton.cursor == self:
				execute()
		)


func play():
	if not wait_for_player:
		execute()


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
	prints(tab + "[SCENARIO] Play scenario action by %s" % self.name)


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
