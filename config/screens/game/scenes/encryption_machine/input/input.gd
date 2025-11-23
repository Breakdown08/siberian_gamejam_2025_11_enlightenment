class_name EncryptionMachineInput extends Control

@onready var display:Label = $panel/margin/display


func on_switch_switched(symbol:String, state:bool):
	display.text += symbol


func on_reset():
	display.text = ""
