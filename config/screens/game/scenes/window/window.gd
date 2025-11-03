extends Control

@onready var morning:TextureRect = $morning
@onready var day:TextureRect = $day
@onready var evening:TextureRect = $evening
@onready var night:TextureRect = $night

var INTERVAL:float = 15.0
var ANIMATION_DURATION:float = 1.0


func _ready() -> void:
	reset_modulate()
	Scenario.cutscene_on.connect(stop_animation)
	Scenario.cutscene_off.connect(animate)
	#animate() # for debug
	
	
func reset_modulate():
	var tween:Tween = Utils.tween(self).set_parallel(true)
	tween.tween_property(morning, "modulate", Color.WHITE, ANIMATION_DURATION)
	tween.tween_property(day, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.tween_property(evening, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.tween_property(night, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)


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
