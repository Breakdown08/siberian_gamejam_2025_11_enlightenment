extends Node2D

@onready var door_open:AudioStreamPlayer = $door_open
@onready var door_close:AudioStreamPlayer = $door_close
@onready var normal_state:Sprite2D = $normal
@onready var angry_state:Sprite2D = $angry

const ANIMATION_DURATION:float = 0.3


func _ready() -> void:
	hide()
	on_normal()
	modulate = Color.TRANSPARENT
	Scenario.friend_has_come.connect(on_friend_has_come)
	Scenario.friend_has_left.connect(on_friend_has_left)
	Scenario.friend_normal.connect(on_normal)
	Scenario.friend_angry.connect(on_angry)


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


func on_normal():
	var tween:Tween = Utils.tween(self, "state").set_parallel()
	tween.tween_property(normal_state, "modulate", Color.WHITE, ANIMATION_DURATION)
	tween.tween_property(angry_state, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)


func on_angry():
	var tween:Tween = Utils.tween(self, "state").set_parallel()
	tween.tween_property(normal_state, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.tween_property(angry_state, "modulate", Color.WHITE, ANIMATION_DURATION)
