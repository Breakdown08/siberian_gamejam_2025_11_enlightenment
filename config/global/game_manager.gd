extends Node

const SAVE_LOAD:PackedScene = preload("res://config/ui/popup/save_load/save_load.tscn")
const SETTINGS:PackedScene = preload("res://config/screens/settings/settings.tscn")

var saves:Array = []
var save_id:int = -1


var game:Game
var act:GameAct = null
var current_actor:Actor = null
var is_cutscene:bool = false
var is_speech_finished = false

signal game_started(game_instance:Game)
signal interactive_item_opened(target:Game.INTERACTIVE_ITEM)
signal back_to_room
signal items_availability_changed
signal items_info_changed
signal item_info
signal game_loaded
signal game_saved
signal game_deleted

enum SAVE_KEYS {
	TIMESTAMP,
	ACT,
	OSCILLOSCOPE_CURVE,
	DIARY_NOTE_OSCILLOSCOPE,
	DIARY_NOTE_RADIO_RESPONSE,
	DIARY_COMMON_NOTES,
	PHOTO_IS_BACK_SIDE,
	PHOTO_IS_CHECKED,
	MORSE_CODE_TEXTBOOK_IS_TRANSLATED,
	DIALOG_HISTORY
}


func _init() -> void:
	Scenario.act_started.connect(func(next_act): act = next_act)
	Scenario.cutscene_started.connect(func(): is_cutscene = true)
	Scenario.cutscene_finished.connect(func(): is_cutscene = false)
	Scenario.speech_started.connect(func(): is_speech_finished = false)
	Scenario.speech_finished.connect(func(): is_speech_finished = true)
	game_started.connect(func(game_instance): start(game_instance))
	Scenario.event.connect(on_scenario_event)


func start(game_instance:Game):
	_init_saves()
	game = game_instance
	act = null
	current_actor = null
	is_cutscene = false
	is_speech_finished = false
	var is_loaded:bool = _game_load()
	if not is_loaded:
		Scenario.skeleton.start()


func on_scenario_event(key:String, value:String = ""):
	if game:
		match key:
			"diary_updated":
				var notify_text:String = Scenario.database.get_key(key)
				game.on_notification(notify_text)
			"back_to_room":
				back_to_room.emit()
			"glasses":
				game.to_final_scene()
				back_to_room.emit()
			"game_over":
				game.to_game_over()


func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_cutscene and is_speech_finished and Scenario.skeleton.cursor != null:
				Scenario.reading_finished.emit()
			elif event.double_click and is_cutscene and Scenario.skeleton.cursor != null:
				Scenario.reading_finished.emit()


func game_save():
	if game:
		var diary = game.get_interactive_item(Game.INTERACTIVE_ITEM.DIARY) as DiaryInteractiveItem
		saves.append({
			SAVE_KEYS.TIMESTAMP : Time.get_unix_time_from_system(),
			SAVE_KEYS.ACT : act.get_node("game").get_path(),
			SAVE_KEYS.OSCILLOSCOPE_CURVE : diary.oscilloscope.last_selected_curve_path,
			SAVE_KEYS.DIARY_NOTE_OSCILLOSCOPE : diary.oscilloscope_params,
			SAVE_KEYS.DIARY_NOTE_RADIO_RESPONSE : diary.radio_response,
			SAVE_KEYS.DIARY_COMMON_NOTES : diary.notes,
			SAVE_KEYS.PHOTO_IS_BACK_SIDE : diary.photo.is_back_side,
			SAVE_KEYS.PHOTO_IS_CHECKED : diary.photo.is_checked,
			SAVE_KEYS.MORSE_CODE_TEXTBOOK_IS_TRANSLATED : diary.morse_code_textbook.is_translated,
			SAVE_KEYS.DIALOG_HISTORY : Scenario.history
		})
		SaveLoad.push(saves)
		game_saved.emit()


func game_load(id:int):
	save_id = id
	if game == null:
		EventBus.screen_switched.emit(Main.SCREEN.GAME)
	else:
		start(game)
	game_loaded.emit()


func game_delete(id:int):
	if id > -1 and id < saves.size():
		saves.remove_at(id)
		SaveLoad.push(saves)
		game_deleted.emit()


func _game_load() -> bool:
	var result:bool = false
	if save_id > -1 and !saves.is_empty() and save_id < saves.size() :
		var data:Dictionary = saves[save_id]
		var game_action:ScenarioSkeletonAction = get_node(data.get(str(SAVE_KEYS.ACT)))
		var diary = game.get_interactive_item(Game.INTERACTIVE_ITEM.DIARY) as DiaryInteractiveItem
		act = game_action.get_parent()
		act.apply_act()
		Scenario.skeleton.cursor = game_action
		diary.oscilloscope.last_selected_curve_path = data.get(str(SAVE_KEYS.OSCILLOSCOPE_CURVE))
		diary.oscilloscope_params = data.get(str(SAVE_KEYS.DIARY_NOTE_OSCILLOSCOPE))
		diary.oscilloscope.params = diary.oscilloscope_params
		diary.radio_response = data.get(str(SAVE_KEYS.DIARY_NOTE_RADIO_RESPONSE))
		diary.notes = data.get(str(SAVE_KEYS.DIARY_COMMON_NOTES)) as Array[String]
		diary.photo.is_back_side = data.get(str(SAVE_KEYS.PHOTO_IS_BACK_SIDE))
		diary.photo.is_checked = data.get(str(SAVE_KEYS.PHOTO_IS_CHECKED))
		diary.morse_code_textbook.is_translated = data.get(str(SAVE_KEYS.MORSE_CODE_TEXTBOOK_IS_TRANSLATED))
		Scenario.history = data.get(str(SAVE_KEYS.DIALOG_HISTORY)) as Array[String]
		save_id = -1
		result = true
		game_loaded.emit()
	return result


func _init_saves():
	var data:String = SaveLoad.pull()
	if not data.is_empty():
		var parsed_data:Array = JSON.parse_string(data)
		saves = parsed_data
