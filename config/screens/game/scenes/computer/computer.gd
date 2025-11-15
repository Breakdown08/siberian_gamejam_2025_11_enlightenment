extends Control

@onready var room:Button = $system_panel/margin/room
@onready var send_signal:Button = $send_signal
@onready var response:Label = $output/margin/response


func _ready():
	room.pressed.connect(func(): GameManager.back_to_room.emit())
	send_signal.pressed.connect(_on_send_signal_pressed)
	Scenario.cutscene_on.connect(
		func():
			send_signal.disabled = true
	)
	Scenario.cutscene_off.connect(
		func():
			send_signal.disabled = false
	)


func success():
	Scenario.computer_response.emit(Scenario.RADIO_RESPONSE)
	Scenario.radio_success_response.emit()
	response.text = Scenario.RADIO_RESPONSE
	#if GameManager.scenario_stage == 1:
		#GameManager.scenario_next()


func empty_response():
	Scenario.computer_response.emit(Scenario.RADIO_RESPONSE_EMPTY)
	response.text = Scenario.RADIO_RESPONSE_EMPTY
	EventBus.thought.emit(Thoughts.RADIO_EMPTY_RESPONSE)


func _on_send_signal_pressed() -> void:
	var oscilloscope:OscilloscopeInteractiveItem = GameManager.game.get_interactive_item(Game.INTERACTIVE_ITEM.OSCILLOSCOPE)
	if oscilloscope.params == Scenario.database.get_key("oscilloscope_correct_params"):
		success()
	else:
		empty_response()
