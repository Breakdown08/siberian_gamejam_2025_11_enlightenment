extends Node

var scenario_id:int = -1
var current_actor:String = ""


func scenario_next():
	if scenario_id < Scenario.data_base.size() - 1:
		scenario_id += 1
		var scenario:Dictionary = Scenario.data_base[scenario_id]
		emit_scenario_dialog(scenario)
		emit_scenario_events(scenario)


func emit_scenario_dialog(scenario:Dictionary):
	if scenario.has_all([Scenario.KEY_ACTOR, Scenario.KEY_SPEECH]):
		var actor:String = scenario[Scenario.KEY_ACTOR]
		var actor_speech:String = scenario[Scenario.KEY_SPEECH]
		if current_actor == actor:
			EventBus.dialog_continue.emit(actor_speech)
		else:
			EventBus.dialog.emit(actor, actor_speech)
		current_actor = actor


func emit_scenario_events(scenario:Dictionary):
	if scenario.has(Scenario.KEY_EVENTS):
		var events:PackedStringArray = scenario[Scenario.KEY_EVENTS]
		for signal_name in events:
			Scenario.emit_signal(signal_name)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if scenario_id < Scenario.data_base.size() - 1:
			#scenario_id = -1
			scenario_next()
