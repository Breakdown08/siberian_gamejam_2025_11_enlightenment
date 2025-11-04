extends Panel


func _ready() -> void:
	modulate = Color.TRANSPARENT


func _input(event:InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_position:Vector2 = get_global_mouse_position()
		if mouse_position.y >= global_position.y and mouse_position.y <= global_position.y + size.y:
			modulate = Color.WHITE
		else:
			modulate = Color.TRANSPARENT


func _process(delta: float) -> void:
	if GameManager.is_cutscene:
		hide()
	else:
		show()
