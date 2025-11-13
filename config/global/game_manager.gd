extends Node

var game:Game
var act:GameAct = null
var current_actor:Actor = null
var is_cutscene:bool = false
var is_speech_finished = false

signal game_started(game_instance:Game)
signal scenario_next
signal interactive_item_opened(target:Game.INTERACTIVE_ITEM)
signal back_to_room
signal items_availability_changed
signal items_info_changed
signal item_info


func _init() -> void:
	Scenario.act_started.connect(func(next_act): act = next_act)
	Scenario.cutscene_started.connect(func(): is_cutscene = true)
	Scenario.cutscene_finished.connect(func(): is_cutscene = false)
	Scenario.speech_started.connect(func(): is_speech_finished = false)
	Scenario.speech_finished.connect(func(): is_speech_finished = true)
	game_started.connect(func(game_instance): start(game_instance))


func start(game_instance:Game):
	game = game_instance
	act = null
	current_actor = null
	is_cutscene = false
	is_speech_finished = false
<<<<<<< HEAD
	Scenario.skeleton.start()
=======
	scenario_next()
	#debug_scenario(67)
	#debug_scenario(127)
	#debug_scenario(180)
	#debug_scenario(207)
>>>>>>> e61611c (Правки по мини-игре)


func on_scenario_event(key:String, value:String = ""):
	match key:
		"diary_updated":
			var notify_text:String = Scenario.database.get_key(key)
			game.on_notification(notify_text)


func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_cutscene and is_speech_finished and Scenario.skeleton.cursor != null:
				Scenario.reading_finished.emit()
			elif event.double_click and is_cutscene and Scenario.skeleton.cursor != null:
				Scenario.reading_finished.emit()
	if Input.is_action_just_pressed("ui_accept"):
		scenario_next.emit()
