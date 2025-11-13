extends Control

@export var load_scene_path : String = "res://config/main.tscn"  # путь к сцене
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

@onready var EyeAnim = $control/EyeAnim
var timer

var tween
var splash_scene
var loaded

func _ready() -> void:
	#Загружаем сцену с меню
	var loader = ResourceLoader.load_threaded_request(load_scene_path)
	if loader == null:
		push_error("Не удалось создать ResourceInteractiveLoader!")
		return
	loaded = ResourceLoader.load_threaded_get(load_scene_path) as PackedScene
	
	#Какие-то костыли с заставками
	fade(1)
	timer = get_tree().create_timer(5)
	await timer.timeout
	#await tween.finished
	timer = get_tree().create_timer(2.4)
	fade(2)
	#await tween.finished
	await timer.timeout  # ждём пока таймер сработает
	
	#Меняем сцену на меню и удаляем эту сцену
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
		EyeAnim.play("Blink")

func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and event.pressed:
		if splash_scene == 1:
			#tween.stop()
			splash_screen.visible = false
			timer.set_time_left(0)
			fade(splash_scene + 1)
		elif splash_scene == 2:
			#tween.stop()
			timer.set_time_left(0)
			change_scene()
