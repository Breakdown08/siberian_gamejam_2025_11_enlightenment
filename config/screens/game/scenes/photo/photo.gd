extends Control

@onready var room:Button = $system_panel/margin/room
@onready var front:TextureRect = $front/front
@onready var back:TextureRect = $back
@onready var front_without_label:TextureRect = $front/front_without_label
@onready var button_flip_photo:Button = $button

var back_side:bool = false

const ANIMATION_DURATION:float = 0.3


func _ready() -> void:
	if GameManager.game:
		var diary:DiaryInteractiveItem = GameManager.game.get_interactive_item(Game.INTERACTIVE_ITEM.DIARY)
		back_side = diary.photo.is_back_side
		match GameManager.act.name:
			"act_2":
				front_without_label.hide()
				front.show()
			"act_3":
				back_side = false
				front_without_label.show()
				front.hide()
				Scenario.next()
				button_flip_photo.hide()
		_animation_flip_side()
	room.pressed.connect(GameManager.back_to_room.emit)
	back.modulate = Color.TRANSPARENT
	#if GameManager.is_photo_turned:
		#front_without_label.hide()
		#back.


func _on_button_pressed() -> void:
	back_side = !back_side
	_animation_flip_side()
	_on_side_changed()


func _animation_flip_side():
	var tween:Tween = Utils.tween(self).set_parallel(true)
	if back_side:
		tween.tween_property(front, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
		tween.tween_property(back, "modulate", Color.WHITE, ANIMATION_DURATION)
	else:
		tween.tween_property(front, "modulate", Color.WHITE, ANIMATION_DURATION)
		tween.tween_property(back, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)


func _on_side_changed():
	if GameManager.game:
		var diary:DiaryInteractiveItem = GameManager.game.get_interactive_item(Game.INTERACTIVE_ITEM.DIARY)
		diary.photo.is_back_side = back_side
		match GameManager.act.name:
			"act_2":
				if back_side == true:
					diary.photo.is_checked = true
					diary.check_act_2_conditions()
