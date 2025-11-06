class_name MorseCodeTextBookUndefined extends Control

@onready var button:Button = $button
@onready var code_node:Label = $code
@onready var char_node:Label = $char

const ANIMATION_DURATION:float = 0.3

signal unsecret


func _ready() -> void:
	button.pressed.connect(on_button_pressed)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	modulate = Color.BLACK


func on_button_pressed():
	if str(GameManager.morse_book_code_selected) == str(code_node.text):
		var result = MorseCodeTextBook.find_symbol_by_code(code_node.text)
		if result != "none":
			char_node.text = result
			show_secret()


func on_mouse_entered():
	modulate = Color.AQUA


func on_mouse_exited():
	modulate = Color.BLACK


func show_secret():
	var tween:Tween = Utils.tween(self).set_parallel(true)
	tween.tween_property(code_node, "self_modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.tween_property(char_node, "self_modulate", Color.WHITE, ANIMATION_DURATION)
	tween.tween_callback(func():
		code_node.hide()
		unsecret.emit()
	)
