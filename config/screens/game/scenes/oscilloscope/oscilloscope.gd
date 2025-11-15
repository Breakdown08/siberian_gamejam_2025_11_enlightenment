extends Control

@onready var room:Button = $system_panel/margin/room
@onready var pot_1:TextureRect = $controls/potentiometer_1

@onready var signals = [
	$display/Curves/signal_1,
	$display/Curves/signal_2,
	$display/Curves/signal_3,
	$display/Curves/signal_4,
	$display/Curves/signal_5,
	$display/Curves/signal_6,
	$display/Curves/signal_7,
	$display/Curves/signal_8,
	$display/Curves/signal_9,
	$display/Curves/signal_10
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
var success:bool = false
var game_end:bool = false


func _ready() -> void:
	room.pressed.connect(func(): GameManager.back_to_room.emit())


func update_diary():
	pass
	#EventBus.notification.emit(Scenario.NOTIFICATION_UPDATE_DIARY)


func write_params():
	Scenario.oscilloscope_write_params.emit(str([1, 2, 3, 4]))


func _on_potentiometer_1_mouse_entered() -> void:
	pot_1_focused = true


func _on_potentiometer_1_mouse_exited() -> void:
	pot_1_focused = false


func _input(event:InputEvent) -> void:
	if !game_end:
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
			
			if signals[7].visible:
				success = true
			else:
				success = false


func _on_write_params_pressed() -> void:
	if success:
		#Мы выиграли. Повесить event
		Scenario.oscilloscope_success.emit()
		game_end = true
	#Scenario.oscilloscope_write_params.emit(str(Vector2(round_to_tenth(curve.scale.x), round_to_tenth(curve.scale.y))))
	EventBus.notification.emit(Scenario.NOTIFICATION_UPDATE_DIARY)
