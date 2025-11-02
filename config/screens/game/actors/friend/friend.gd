extends Node2D

const ANIMATION_DURATION:float = 0.3


func _ready() -> void:
	hide()
	modulate = Color.TRANSPARENT
	Scenario.friend_has_come.connect(on_friend_has_come)
	Scenario.friend_has_left.connect(on_friend_has_left)


func on_friend_has_come():
	show()
	var tween:Tween = Utils.tween(self)
	tween.tween_property(self, "modulate", Color.WHITE, ANIMATION_DURATION)


func on_friend_has_left():
	var tween:Tween = Utils.tween(self)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.tween_callback(func():
		hide()
	)
