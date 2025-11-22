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
	"res://sound_fx/minigame1/encoder_3.mp3",
	"res://sound_fx/minigame1/encoder_4.mp3",
	"res://sound_fx/minigame1/encoder_5.mp3",
	"res://sound_fx/minigame1/encoder_6.mp3",
	"res://sound_fx/minigame1/encoder_7.mp3",
	"res://sound_fx/minigame1/encoder_8.mp3"
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
	if interactive_item and !interactive_item.last_selected_curve_path.is_empty():
		for curve in signals:
			curve.hide()
		selected_curve = get_node(interactive_item.last_selected_curve_path)
		signal_pos = selected_curve.get_index()
		selected_curve.show()
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
	var clicked
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				clicked = event.pressed
	
	if (event is InputEventMouseButton and event.pressed and pot_1_focused) or (clicked and pot_1_focused):
		SoundManager.play_sfx(load(sounds[randi_range(0,5)]))
		signals[signal_pos].visible = false
		if event.button_index in [MOUSE_BUTTON_WHEEL_UP]:
			if signal_pos > 0:
				signal_pos -= 1
				pot_1.rotation_degrees -= 10
			else:
				signal_pos = 9
		elif event.button_index in [MOUSE_BUTTON_WHEEL_DOWN] or clicked:
			if signal_pos < 9:
				signal_pos += 1
				pot_1.rotation_degrees += 10
			else:
				signal_pos = 0
		signals[signal_pos].visible = true
		selected_curve = signals[signal_pos]
