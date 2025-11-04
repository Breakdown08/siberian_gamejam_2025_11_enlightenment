extends Control

@onready var room:Button = $system_panel/margin/room
@onready var send_signal:Button = $send_signal
@onready var response:Label = $output/margin/response


func _ready():
	room.pressed.connect(_on_room_pressed)
	send_signal.pressed.connect(_on_send_signal_pressed)
	Scenario.cutscene_on.connect(
		func():
			send_signal.disabled = true
	)
	Scenario.cutscene_off.connect(
		func():
			send_signal.disabled = false
	)
	Scenario.back_to_room.connect(_on_room_pressed)


func _on_room_pressed():
	EventBus.scene_switched.emit(Game.SCENE.MAIN)


func success():
	Scenario.computer_response.emit(Scenario.RADIO_RESPONSE)
	response.text = Scenario.RADIO_RESPONSE
	GameManager.scenario_next()


func empty_response():
	Scenario.computer_response.emit(Scenario.RADIO_RESPONSE_EMPTY)
	response.text = Scenario.RADIO_RESPONSE_EMPTY
	EventBus.thought.emit(Thoughts.RADIO_EMPTY_RESPONSE)


func _on_send_signal_pressed() -> void:
	if GameManager.oscilloscope_params == Scenario.OSCILLOSCOPE_PARAMS:
		success()
	else:
		empty_response()
