class_name SaveLoadItem extends Control

@onready var title:Label = $margin/body/title
@onready var button:Button = $button

signal selected(id)

var timestamp:float = 0.0


func _ready() -> void:
	name = str(int(timestamp))
	title.text = Time.get_datetime_string_from_unix_time(int(timestamp), true)
	button.pressed.connect(selected.emit.bind(get_index()))
