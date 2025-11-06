class_name EncryptionMachineSwitch  extends Control

@onready var enable:TextureButton = $state/enable
@onready var disable:TextureButton = $state/disable
@onready var symbol:Label = $symbol

signal switched(symbol:String, state:bool)

var _state:bool = false
var state:bool = false:
	set(new_value):
		if new_value == true:
			enable.show()
			disable.hide()
		else:
			enable.hide()
			disable.show()
		_state = new_value
		switched.emit(symbol.text, _state)
	get():
		return _state


func _ready() -> void:
	_state = false
	enable.hide()
	disable.show()


func _on_enable_pressed() -> void:
	self.state = !state


func _on_disable_pressed() -> void:
	self.state = !state
