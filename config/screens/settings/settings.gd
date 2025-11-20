extends Control

@onready var button_back_menu:Button = $panel/margin/list/back_menu
@onready var slider_music = $panel/margin/list/slider_music
@onready var slider_sfx = $panel/margin/list/slider_sfx

func _ready() -> void:
	button_back_menu.pressed.connect(on_button_back_menu_pressed)
	
	if GameManager.game:
		$panel.set_offsets_preset(Control.PRESET_CENTER)

	
	slider_music.value = SoundManager.music_volume
	slider_sfx.value = SoundManager.sfx_volume


func _on_sld_music_value_changed(value: float) -> void:
	SoundManager.music_volume = value
	SoundManager.update_volumes()


func _on_slider_sfx_value_changed(value: float) -> void:
	SoundManager.sfx_volume = value
	SoundManager.update_volumes()

func on_button_back_menu_pressed():
	self.get_parent().find_child('panel').visible = true
	queue_free()
