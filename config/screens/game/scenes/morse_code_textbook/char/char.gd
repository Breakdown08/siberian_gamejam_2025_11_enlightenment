class_name MorseCodeTextBookChar extends Control

@onready var code:Label = $panel/body/code
@onready var symbol:Label = $panel/body/symbol
@onready var button:Button = $button

const COLOR_DEFAULT:Color = Color.BLACK

signal selected(target:MorseCodeTextBookChar)

var book:MorseCodeTextBook

var is_selected:bool = false


func set_char(code_text:String, symbol_text:String):
	code.text = code_text
	symbol.text = symbol_text


func _ready() -> void:
	modulate = COLOR_DEFAULT
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button.pressed.connect(_on_button_pressed)


func _on_mouse_entered():
	if is_selected:
		return
	modulate = Color.AQUA


func _on_mouse_exited():
	if is_selected:
		return
	modulate = COLOR_DEFAULT


func _on_button_pressed():
	selected.emit(self)
	is_selected = true
	book.code_selected = code.text
