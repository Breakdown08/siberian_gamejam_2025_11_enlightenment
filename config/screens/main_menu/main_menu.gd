extends Control

@onready var button_exit:Button = $panel/margin/list/exit
@onready var button_play:Button = $panel/margin/list/play


func _ready() -> void:
	button_exit.pressed.connect(on_button_exit_pressed)
	button_play.pressed.connect(on_button_play_pressed)


func on_button_exit_pressed():
	get_tree().quit()


func on_button_play_pressed():
	EventBus.screen_switched.emit(Main.SCREEN.GAME)
