class_name Notification extends Control

const ANIMATION_DURATION:float = 0.3

@onready var message:Label = $panel/margin/center_container/message


func _ready() -> void:
	modulate = Color.TRANSPARENT
	var tween:Tween = Utils.tween(self)
	tween.tween_property(self, "modulate", Color.WHITE, ANIMATION_DURATION)


func _on_timer_timeout() -> void:
	var tween:Tween = Utils.tween(self)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.tween_callback(func():
		queue_free()
	)
