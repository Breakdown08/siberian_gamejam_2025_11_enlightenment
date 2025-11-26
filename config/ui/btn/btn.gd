class_name Btn extends TextureButton

@export var text:String = ""


func _ready() -> void:
	$label.text = text
