extends Control

@onready var room:Button = $system_panel/margin/room
@onready var pot_1:TextureRect = $controls/potentiometer_1
@onready var pot_2:TextureRect = $controls/potentiometer_2
@onready var curve:TextureRect = $display/curve

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
var signal_pos = 0

var pot_1_focused:bool = false
var pot_2_focused:bool = false

const POT_ROTATION_STEP:int = 5
const COEF:float = 0.05

var pot_1_percent:float = 0.0
var pot_2_percent:float = 0.0

var init_scale:Vector2

var success:bool = false
var game_end:bool = false


func _ready() -> void:
	init_scale = scale
	room.pressed.connect(func(): GameManager.back_to_room.emit())


func write_params():
	Scenario.oscilloscope_write_params.emit(str([1, 2, 3, 4]))


func _on_potentiometer_1_mouse_entered() -> void:
	pot_1_focused = true


func _on_potentiometer_1_mouse_exited() -> void:
	pot_1_focused = false


func _on_potentiometer_2_mouse_entered() -> void:
	pot_2_focused = true


func _on_potentiometer_2_mouse_exited() -> void:
	pot_2_focused = false


func round_to_tenth(value: float) -> float:
	return round(value * 10.0) / 10.0



func _input(event:InputEvent) -> void:
	if !game_end:
		if event is InputEventMouseButton and event.pressed:
			signals[signal_pos].visible = false
			if event.button_index in [MOUSE_BUTTON_WHEEL_UP]:
				print('UP signal before: ' + str(signal_pos))
				if signal_pos > 0:
					signal_pos -= 1
				else:
					signal_pos = 9
				print('UP signal after: ' + str(signal_pos))

			elif event.button_index in [MOUSE_BUTTON_WHEEL_DOWN]:
				print('DOWN signal before: ' + str(signal_pos))
				if signal_pos < 9:
					signal_pos += 1
				else:
					signal_pos = 0
				print('DOWN signal after: ' + str(signal_pos))
			signals[signal_pos].visible = true
			
			if signals[7].visible:
				print('true')
				success = true
			else:
				print('false')
				success = false
				
				#var polarity:int = 1 if event.button_index == MOUSE_BUTTON_WHEEL_UP else -1
				#if pot_1_focused:
					#on_pot_1(polarity)
				#if pot_2_focused:
					#on_pot_2(polarity)
				#var rounded = Vector2(round_to_tenth(curve.scale.x), round_to_tenth(curve.scale.y))
				#if rounded == Vector2.ONE:
					#curve.modulate = Color.GREEN
					#success = true
					#Scenario.oscilloscope_success.emit()
				#else:
					#curve.modulate = Color.WHITE


func on_pot_1(polarity:int):
	pot_1.rotation_degrees += POT_ROTATION_STEP * polarity
	curve.scale.x = clampf(curve.scale.x + COEF * polarity, 0.8, 3.0)


func on_pot_2(polarity:int):
	pot_2.rotation_degrees += POT_ROTATION_STEP * polarity
	curve.scale.y = clampf(curve.scale.y + COEF * polarity, -2, 3.0)


func _on_write_params_pressed() -> void:
	if success:
		#Тут по сути всё, пизда, мы выиграли
		Scenario.oscilloscope_success.emit()
		game_end = true
	Scenario.oscilloscope_write_params.emit(str(Vector2(round_to_tenth(curve.scale.x), round_to_tenth(curve.scale.y))))
	EventBus.notification.emit(Scenario.NOTIFICATION_UPDATE_DIARY)
