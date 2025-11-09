extends Control

@onready var room:Button = $system_panel/margin/room
@onready var front:TextureRect = $front/front
@onready var back:TextureRect = $back
@onready var front_without_label:TextureRect = $front/front_without_label

var back_side:bool = false

const ANIMATION_DURATION:float = 0.3


func _ready() -> void:
	if GameManager.is_photo_opened and GameManager.scenario_id < 198:
		front_without_label.show()
		front.hide()
		GameManager.scenario_next.emit()
		#$button.hide()
	room.pressed.connect(func(): GameManager.back_to_room.emit())
	back.modulate = Color.TRANSPARENT
	#if GameManager.is_photo_turned:
		#front_without_label.hide()
		#back.


func _on_button_pressed() -> void:
	if !GameManager.is_photo_turned:
		Scenario.photo_back_side_checked.emit()
		#EventBus.notification.emit(Scenario.NOTIFICATION_UPDATE_DIARY)
	back_side = !back_side
	var tween:Tween = Utils.tween(self).set_parallel(true)
	if back_side:
		tween.tween_property(front, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
		tween.tween_property(back, "modulate", Color.WHITE, ANIMATION_DURATION)
	else:
		tween.tween_property(front, "modulate", Color.WHITE, ANIMATION_DURATION)
		tween.tween_property(back, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
