extends Control

@onready var logo:TextureRect = $logo
@onready var eye:Control = $eye
@onready var eye_sprite:AnimatedSprite2D = $eye/sprite

@export var main:PackedScene = null

enum ANIMATION {LOGO, EYE}

var current_animation = ANIMATION.LOGO


func _ready() -> void:
	logo.modulate = Color.TRANSPARENT
	eye.modulate = Color.TRANSPARENT
	_animation_logo()


func _animation_logo():
	current_animation = ANIMATION.LOGO
	var tween:Tween = Utils.tween(self)
	tween.tween_property(logo, "modulate", Color.WHITE, 1.5)
	tween.tween_property(logo, "modulate", Color.TRANSPARENT, 1.5)
	tween.tween_callback(func(): _animation_eye())
	

func _animation_eye():
	logo.hide()
	current_animation = ANIMATION.EYE
	eye_sprite.play()
	var tween:Tween = Utils.tween(self)
	tween.tween_property(eye, "modulate", Color.WHITE, 1.5)
	tween.tween_property(eye, "modulate", Color.TRANSPARENT, 1.5)
	tween.tween_callback(func():
		get_tree().change_scene_to_packed(main)
	)


func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and event.pressed:
		match current_animation:
			ANIMATION.LOGO:
				_animation_eye()
			ANIMATION.EYE:
				get_tree().change_scene_to_packed(main)
