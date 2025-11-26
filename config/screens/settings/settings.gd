extends Control

@onready var button_back_to_menu:Button = $panel/margin/list/back_to_menu
@onready var slider_music = $panel/margin/list/slider_music
@onready var slider_sfx = $panel/margin/list/slider_sfx


func _ready() -> void:
	button_back_to_menu.pressed.connect(_on_button_back_to_menu_pressed)
	slider_music.value_changed.connect(_on_slider_music_value_changed)
	slider_sfx.value_changed.connect(_on_slider_sfx_value_changed)
	if GameManager.game: $panel.set_offsets_preset(Control.PRESET_CENTER)
	slider_music.value = SoundManager.music_volume
	slider_sfx.value = SoundManager.sfx_volume


func _on_slider_music_value_changed(value: float) -> void:
	SoundManager.music_volume = value
	SoundManager.update_volumes()


func _on_slider_sfx_value_changed(value: float) -> void:
	SoundManager.sfx_volume = value
	SoundManager.update_volumes()


func _on_button_back_to_menu_pressed():
	self.get_parent().find_child('panel').visible = true
	queue_free()
