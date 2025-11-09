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

func _ready() -> void:
	fade()

func fade() -> void:
	splash_screen.modulate.a = 0.0
	var tween = self.create_tween()
	tween.tween_interval(in_time)
	tween.tween_property(splash_screen, "modulate:a", 1.0, fade_in_time)
	tween.tween_interval(pause_time)
	tween.tween_property(splash_screen, "modulate:a", 0.0, fade_out_time)
	tween.tween_interval(out_time)
	
	eye1.modulate.a = 0.0
	tween.tween_interval(in_time)
	tween.tween_property(eye1, "modulate:a", 1.0, fade_in_time)
	tween.tween_interval(pause_time)
	tween.tween_property(eye1, "modulate:a", 0.0, fade_out_time)
	tween.tween_interval(out_time)
	
	await tween.finished
	var loader = ResourceLoader.load_threaded_request(load_scene_path)
	if loader == null:
		push_error("Не удалось создать ResourceInteractiveLoader!")
		return
	
	var loaded = ResourceLoader.load_threaded_get(load_scene_path) as PackedScene
	if loaded:
		get_tree().change_scene_to_packed(loaded)
	else:
		push_error("Не удалось получить загруженную сцену.")
