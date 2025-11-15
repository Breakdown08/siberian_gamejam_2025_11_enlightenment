extends Control

@onready var room:Button = $system_panel/margin/room
@onready var pot_1:TextureRect = $controls/potentiometer_1
@onready var write_params_button:Button = $write_params

@onready var signals = [
	$display/curves/signal_1,
	$display/curves/signal_2,
	$display/curves/signal_3,
	$display/curves/signal_4,
	$display/curves/signal_5,
	$display/curves/signal_6,
	$display/curves/signal_7,
	$display/curves/signal_8,
	$display/curves/signal_9,
	$display/curves/signal_10
]

@onready var sounds = [
	$controls/encoder_3,
	$controls/encoder_4,
	$controls/encoder_5,
	$controls/encoder_6,
	$controls/encoder_7,
	$controls/encoder_8
]

var pot_1_focused:bool = false
var signal_pos = 0
var selected_curve:TextureRect = null
var interactive_item:OscilloscopeInteractiveItem


func _ready() -> void:
	if GameManager.game:
		interactive_item = GameManager.game.get_interactive_item(Game.INTERACTIVE_ITEM.OSCILLOSCOPE)
	room.pressed.connect(func(): GameManager.back_to_room.emit())
	write_params_button.pressed.connect(_write_params)
	if interactive_item and interactive_item.params:
		for curve in signals:
			hide()
		interactive_item.params.show()
		selected_curve = interactive_item.params
	else:
		selected_curve = signals[0]


func _write_params():
	if interactive_item:
		interactive_item.update_params(selected_curve)


func _on_potentiometer_1_mouse_entered() -> void:
	pot_1_focused = true


func _on_potentiometer_1_mouse_exited() -> void:
	pot_1_focused = false


func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and pot_1_focused:
		sounds[randi_range(0,5)].play()
		signals[signal_pos].visible = false
		if event.button_index in [MOUSE_BUTTON_WHEEL_UP]:
			if signal_pos > 0:
				signal_pos -= 1
				pot_1.rotation_degrees -= 10
			else:
				signal_pos = 9
		elif event.button_index in [MOUSE_BUTTON_WHEEL_DOWN]:
			if signal_pos < 9:
				signal_pos += 1
				pot_1.rotation_degrees += 10
			else:
				signal_pos = 0
		signals[signal_pos].visible = true
		selected_curve = signals[signal_pos]
