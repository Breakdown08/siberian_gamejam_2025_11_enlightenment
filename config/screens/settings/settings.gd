extends Control

@onready var button_back_menu:Button = $panel/margin/list/back_menu
@onready var screen = $Screen_2
@onready var slider_music = $panel/margin/list/slider_music
@onready var slider_sfx = $panel/margin/list/slider_sfx

func _ready() -> void:
	button_back_menu.pressed.connect(on_button_back_menu_pressed)
	
	screen.modulate.a = 0.0
	start_fade_cycle()
	
	slider_music.value = SoundManager.music_volume
	slider_sfx.value = SoundManager.sfx_volume


func start_fade_cycle():
	var tween:Tween = Utils.tween(self)
	tween.tween_property(self, "screen:modulate:a", 1.0, 0.7).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "screen:modulate:a", 0.0, 4.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(start_fade_cycle)
	
func on_button_back_menu_pressed():
	print(GameManager.game)
	#EventBus.screen_switched.emit(Main.SCREEN.MAIN_MENU)


func _on_sld_music_value_changed(value: float) -> void:
	SoundManager.music_volume = value
	SoundManager.update_volumes()


func _on_slider_sfx_value_changed(value: float) -> void:
	SoundManager.sfx_volume = value
	SoundManager.update_volumes()
