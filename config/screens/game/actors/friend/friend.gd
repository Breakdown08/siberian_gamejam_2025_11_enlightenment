extends Node2D

@onready var door_open = "res://sound_fx/door/fx_1.mp3"
@onready var door_close = "res://sound_fx/door/fx_2.mp3"
@onready var normal_state:Sprite2D = $normal
@onready var angry_state:Sprite2D = $angry

const ANIMATION_DURATION:float = 0.3


func _ready() -> void:
	hide()
	on_normal()
	modulate = Color.TRANSPARENT
	Scenario.event.connect(on_scenario_event)


func on_friend_has_come():
	SoundManager.play_sfx(load(door_open))
	show()
	var tween:Tween = Utils.tween(self)
	tween.tween_property(self, "modulate", Color.WHITE, ANIMATION_DURATION)


func on_friend_has_left():
	SoundManager.play_sfx(load(door_close))
	var tween:Tween = Utils.tween(self)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.tween_callback(func():
		hide()
	)


func on_normal():
	var tween:Tween = Utils.tween(self, "state").set_parallel()
	tween.tween_property(normal_state, "modulate", Color.WHITE, ANIMATION_DURATION)
	tween.tween_property(angry_state, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)


func on_angry():
	var tween:Tween = Utils.tween(self, "state").set_parallel()
	tween.tween_property(normal_state, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.tween_property(angry_state, "modulate", Color.WHITE, ANIMATION_DURATION)


func on_scenario_event(key:String, value:String):
	match key:
		"friend_has_come":
			on_friend_has_come()
		"friend_has_left":
			on_friend_has_left()
		"friend_normal":
			on_normal()
		"friend_angry":
			on_angry()
