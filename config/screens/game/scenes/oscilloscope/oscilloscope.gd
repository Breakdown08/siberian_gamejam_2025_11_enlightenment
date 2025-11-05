extends Control

@onready var room:Button = $system_panel/margin/room
@onready var pot_1:TextureRect = $controls/potentiometer_1
@onready var pot_2:TextureRect = $controls/potentiometer_2
@onready var curve:TextureRect = $display/curve

var pot_1_focused:bool = false
var pot_2_focused:bool = false

const POT_ROTATION_STEP:int = 5
const COEF:float = 0.05

var pot_1_percent:float = 0.0
var pot_2_percent:float = 0.0

var init_scale:Vector2

var success:bool = false


func _ready() -> void:
	init_scale = scale
	room.pressed.connect(_on_room_pressed)


func _on_cheat_button_pressed() -> void:
	write_params()
	update_diary()


func _on_room_pressed():
	EventBus.scene_switched.emit(Game.SCENE.MAIN)


func update_diary():
	EventBus.notification.emit(Scenario.NOTIFICATION_UPDATE_DIARY)


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
	if !success:
		if event is InputEventMouseButton:
			if event.button_index in [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN]:
				var polarity:int = 1 if event.button_index == MOUSE_BUTTON_WHEEL_UP else -1
				if pot_1_focused:
					on_pot_1(polarity)
				if pot_2_focused:
					on_pot_2(polarity)
				var rounded = Vector2(round_to_tenth(curve.scale.x), round_to_tenth(curve.scale.y))
				if rounded == Vector2.ONE:
					curve.modulate = Color.GREEN
					success = true
					Scenario.oscilloscope_success.emit()
				else:
					curve.modulate = Color.WHITE


func on_pot_1(polarity:int):
	pot_1.rotation_degrees += POT_ROTATION_STEP * polarity
	curve.scale.x = clampf(curve.scale.x + COEF * polarity, 0.8, 3.0)


func on_pot_2(polarity:int):
	pot_2.rotation_degrees += POT_ROTATION_STEP * polarity
	curve.scale.y = clampf(curve.scale.y + COEF * polarity, -2, 3.0)


func _on_write_params_pressed() -> void:
	Scenario.oscilloscope_write_params.emit(str(Vector2(round_to_tenth(curve.scale.x), round_to_tenth(curve.scale.y))))
	EventBus.notification.emit(Scenario.NOTIFICATION_UPDATE_DIARY)
