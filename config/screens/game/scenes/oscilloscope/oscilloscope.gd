extends Control

@onready var room:Button = $system_panel/margin/room

var area_count = 4
@onready var areas = [
	$signals/Area_1,
	$signals/Area_2,
	$signals/Area_3,
	$signals/Area_4
]
var move_speed = 20.0
var move_element = null

var bg_width = 610
@onready var peaks = [
	$signals/peak_1,
	$signals/peak_2,
	$signals/peak_3,
	$signals/peak_4
]

var first_encoder_wheel = false
var second_encoder_wheel = false
var third_encoder_wheel = false
var fourth_encoder_wheel = false
var zone_occupied := {}  # ключ = зона (ColorRect), значение = пик

func _process(_delta):
	_check_peaks()
	
func _check_peaks():
	var area_occupancy = []
	area_occupancy.resize(areas.size())
	area_occupancy.fill(null)

	for peak in peaks:
		var peak_center = peak.position.x + peak.size.x / 2
		var peak_left = peak.position.x
		var assigned = false

		for i in range(areas.size()):
			var area = areas[i]
			var left = area.position.x
			var right = area.position.x + area.size.x
			
			#if peak.name == "peak_4" and area.name == "Area_4":
				#area_occupancy[i] = peak
				#peak.modulate = Color(0, 1, 0)
				#assigned = true
				#break
			if peak_center >= left and peak_center <= right:
				if area_occupancy[i] != null:
					peak.modulate = Color(1, 0, 0)
					area_occupancy[i].modulate = Color(1, 0, 0)
				else:
					area_occupancy[i] = peak
					peak.modulate = Color(0, 1, 0)
				assigned = true
				break


func _on_cheat_button_pressed() -> void:
	write_params()
	update_diary()


func _on_room_pressed():
	EventBus.scene_switched.emit(Game.SCENE.MAIN)


func update_diary():
	EventBus.notification.emit(Scenario.NOTIFICATION_UPDATE_DIARY)


func write_params():
	Scenario.oscilloscope_write_params.emit(str([1, 2, 3, 4]))


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if move_element != null:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
				move_element.position.x -= move_speed
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
				move_element.position.x += move_speed


func _on_potentiometer_2_mouse_entered() -> void:
	first_encoder_wheel = true
	move_element = peaks[0]

func _on_potentiometer_2_mouse_exited() -> void:
	first_encoder_wheel = false
	move_element = null

func _on_potentiometer_1_mouse_entered() -> void:
	second_encoder_wheel = true
	move_element = peaks[1]

func _on_potentiometer_1_mouse_exited() -> void:
	second_encoder_wheel = false
	move_element = null

func _on_potentiometer_4_mouse_entered() -> void:
	third_encoder_wheel = true
	move_element = peaks[2]

func _on_potentiometer_4_mouse_exited() -> void:
	third_encoder_wheel = false
	move_element = null

func _on_potentiometer_5_mouse_entered() -> void:
	fourth_encoder_wheel = true
	move_element = peaks[3]

func _on_potentiometer_5_mouse_exited() -> void:
	fourth_encoder_wheel = false
	move_element = null
