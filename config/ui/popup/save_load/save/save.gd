class_name SaveLoadItem extends Control

@onready var title:Label = $margin/body/title

var timestamp:String = ""


func _ready() -> void:
	title.text = timestamp
