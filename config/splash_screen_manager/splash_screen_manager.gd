extends Control

@export var load_scene_path : String = "res://config/main.tscn"
@export var in_time : float = 0.5
@export var fade_in_time : float = 1.5
@export var pause_time : float = 1.5
@export var fade_out_time : float = 1.5
@export var out_time : float = 0.5
@export var splash_screen : TextureRect
@export var eye1 : TextureRect
@export var eye2 : TextureRect
@export var eye3 : TextureRect
@export var eye4 : TextureRect
@export var eye5 : TextureRect

@onready var eye_anim = $control/eye_anim

var timer
var tween
var splash_scene
var loaded

func _ready() -> void:
	var loader = ResourceLoader.load_threaded_request(load_scene_path)
	if loader == null:
		push_error("Не удалось создать ResourceInteractiveLoader!")
		return
	loaded = ResourceLoader.load_threaded_get(load_scene_path) as PackedScene
	
	#Реализация начальных заставок
	fade(1)
	timer = get_tree().create_timer(5)
	await timer.timeout
	
	timer = get_tree().create_timer(2.4)
	fade(2)
	await timer.timeout
	
	change_scene()


func change_scene():
	if loaded:
		get_tree().change_scene_to_packed(loaded)
		self.queue_free() 
	else:
		push_error("Не удалось получить загруженную сцену.")

func fade(step):
	splash_scene = step
	if splash_scene == 1:
		tween = self.create_tween()
		splash_screen.modulate.a = 0.0
		tween.tween_interval(in_time)
		tween.tween_property(splash_screen, "modulate:a", 1.0, fade_in_time)
		tween.tween_interval(pause_time)
		tween.tween_property(splash_screen, "modulate:a", 0.0, fade_out_time)
		tween.tween_interval(out_time)
	
	if splash_scene == 2:
		eye_anim.play("blink")

func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and event.pressed:
		timer.set_time_left(0)
		if splash_scene == 1:
			splash_screen.visible = false
			fade(splash_scene + 1)
		elif splash_scene == 2:
			change_scene()
