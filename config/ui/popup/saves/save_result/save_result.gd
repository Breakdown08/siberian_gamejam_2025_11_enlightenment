extends Control

@onready var info:Label = $panel/margin/body/info


func set_info(info_text:String):
	info.text = info_text
