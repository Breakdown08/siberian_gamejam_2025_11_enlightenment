extends Node2D

@onready var door_open:AudioStreamPlayer = $door_open
@onready var door_close:AudioStreamPlayer = $door_close

const ANIMATION_DURATION:float = 0.3


func _ready() -> void:
	hide()
	modulate = Color.TRANSPARENT
	Scenario.friend_has_come.connect(on_friend_has_come)
	Scenario.friend_has_left.connect(on_friend_has_left)


func on_friend_has_come():
	door_open.play()
	show()
	var tween:Tween = Utils.tween(self)
	tween.tween_property(self, "modulate", Color.WHITE, ANIMATION_DURATION)


func on_friend_has_left():
	door_close.play()
	var tween:Tween = Utils.tween(self)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.tween_callback(func():
		hide()
	)
