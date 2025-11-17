extends Control

@onready var button_exit:Button = $panel/margin/list/exit
@onready var button_play:Button = $panel/margin/list/play
@onready var button_load:Button = $panel/margin/list/load

@onready var screen = $Screen_2


func _ready() -> void:
	button_exit.pressed.connect(on_button_exit_pressed)
	button_play.pressed.connect(on_button_play_pressed)
	button_load.pressed.connect(on_button_load_pressed)
	
	screen.modulate.a = 0.0
	start_fade_cycle()


func start_fade_cycle():
	var tween = create_tween()
	# Появляемся
	tween.tween_property(self, "screen:modulate:a", 1.0, 0.7).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# Исчезаем
	tween.tween_property(self, "screen:modulate:a", 0.0, 4.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# Когда цикл закончится запустим снова
	tween.finished.connect(start_fade_cycle)


func on_button_exit_pressed():
	get_tree().quit()


func on_button_play_pressed():
	EventBus.screen_switched.emit(Main.SCREEN.GAME)


func on_button_load_pressed():
	var saves:Saves = Main.SAVE_LOAD.instantiate()
	saves.hide_save_button = true
	add_child(saves)
