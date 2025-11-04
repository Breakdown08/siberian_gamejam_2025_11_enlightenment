extends Node

var scenario_id:int = -1
var scenario_stage:int = 1
var current_actor:String = ""
var is_cutscene:bool = false
var is_speech_finished = false

var oscilloscope_params:String = ""
var oscilloscope_is_locked:bool = false


func _init() -> void:
	Scenario.cutscene_on.connect(func():
		is_cutscene = true
	)
	Scenario.cutscene_off.connect(func():
		is_cutscene = false
	)
	EventBus.speech_started.connect(func():
		is_speech_finished = false
	)
	EventBus.speech_finished.connect(func():
		is_speech_finished = true
	)
	EventBus.game_started.connect(func():
		start()
	)


func start():
	scenario_id = -1
	scenario_stage = 1
	current_actor = ""
	is_cutscene = false
	is_speech_finished = false
	scenario_next()
	#debug_scenario(65)


func scenario_next():
	if scenario_id < Scenario.data_base.size() - 1:
		scenario_id += 1
		var scenario:Dictionary = Scenario.data_base[scenario_id]
		emit_scenario_dialog(scenario)
		emit_scenario_events(scenario)
		EventBus.scenario_id_updated.emit(scenario_id)


func debug_scenario(id:int):
	for i in range(id+1):
		scenario_next()


func emit_scenario_dialog(scenario:Dictionary):
	if scenario.has_all([Scenario.KEY_ACTOR, Scenario.KEY_SPEECH]):
		var actor:String = scenario[Scenario.KEY_ACTOR]
		var actor_speech:String = scenario[Scenario.KEY_SPEECH]
		EventBus.dialog.emit(actor, actor_speech)
		current_actor = actor


func emit_scenario_events(scenario:Dictionary):
	if scenario.has(Scenario.KEY_EVENTS):
		var events:PackedStringArray = scenario[Scenario.KEY_EVENTS]
		for signal_name in events:
			Scenario.emit_signal(signal_name)


func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_cutscene and is_speech_finished and scenario_id < Scenario.data_base.size() - 1:
				scenario_next()


# Запись игровых состояний:
func _ready() -> void:
	Scenario.oscilloscope_unlocked.connect(
		func():
			oscilloscope_is_locked = true
	)
	Scenario.oscilloscope_write_params.connect(
		func(new_value):
			oscilloscope_params = new_value
	)
