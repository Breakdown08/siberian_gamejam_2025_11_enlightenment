extends Control

@onready var room:Button = $system_panel/margin/room
@onready var send_signal:Button = $send_signal
@onready var response:Label = $output/margin/response

@onready var sfx_element = "res://sound_fx/radio/white_noise.mp3"


func _ready():
	room.pressed.connect(func(): GameManager.back_to_room.emit())
	send_signal.pressed.connect(_on_send_signal_pressed)


func success():
	var response_text:String = Scenario.database.get_key("radio_response_success")
	update_radio_response(response_text)
	if GameManager.act and GameManager.act.name == "act_1":
		Scenario.next()
		send_signal.hide()


func empty_response():
	var response_text:String = Scenario.database.get_key("radio_response_empty")
	update_radio_response(response_text)
	GameManager.on_scenario_event("diary_updated")


func _on_send_signal_pressed() -> void:
	var oscilloscope:OscilloscopeInteractiveItem = GameManager.game.get_interactive_item(Game.INTERACTIVE_ITEM.OSCILLOSCOPE)
	if oscilloscope.params == Scenario.database.get_key("oscilloscope_correct_params"):
		SoundManager.play_sfx(load(sfx_element))
		success()
	else:
		empty_response()


func update_radio_response(response_text:String):
	response.text = response_text
	if GameManager.game:
		var computer = GameManager.game.get_interactive_item(Game.INTERACTIVE_ITEM.COMPUTER) as ComputerInteractiveItem
		computer.update_radio_response(response_text)
