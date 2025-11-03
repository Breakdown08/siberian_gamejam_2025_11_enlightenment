extends Control

@onready var morning:TextureRect = $morning
@onready var day:TextureRect = $day
@onready var evening:TextureRect = $evening
@onready var night:TextureRect = $night

var INTERVAL:float = 3.0
var ANIMATION_DURATION:float = 1.0


func _ready() -> void:
	reset_modulate()
	EventBus.speech_started.connect(stop_animation)
	EventBus.speech_finished.connect(animate)
	animate() # for debug
	
	
func reset_modulate():
	morning.modulate = Color.WHITE
	day.modulate = Color.TRANSPARENT
	evening.modulate = Color.TRANSPARENT
	night.modulate = Color.TRANSPARENT


func animate():
	var tween:Tween = Utils.tween(self)
	tween.tween_property(night, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.parallel().tween_property(morning, "modulate", Color.WHITE, ANIMATION_DURATION)
	tween.tween_interval(INTERVAL)
	tween.tween_property(morning, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.parallel().tween_property(day, "modulate", Color.WHITE, ANIMATION_DURATION)
	tween.tween_interval(INTERVAL)
	tween.tween_property(day, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.parallel().tween_property(evening, "modulate", Color.WHITE, ANIMATION_DURATION)
	tween.tween_interval(INTERVAL)
	tween.tween_property(evening, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.parallel().tween_property(night, "modulate", Color.WHITE, ANIMATION_DURATION)
	tween.tween_interval(INTERVAL)
	tween.tween_callback(func():
		animate()
	)


func stop_animation():
	reset_modulate()
	var tween:Tween = Utils.tween(self)
	tween.tween_interval(0.0)
