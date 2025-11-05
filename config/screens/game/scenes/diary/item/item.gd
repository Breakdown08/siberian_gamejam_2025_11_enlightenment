class_name DiaryItem extends Control

@onready var key:Label = $box/key
@onready var value:Label = $box/value


func write_value(new_value:String):
	value.text = new_value
