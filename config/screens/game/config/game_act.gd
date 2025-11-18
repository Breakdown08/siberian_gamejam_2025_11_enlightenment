class_name GameAct extends Act

@export var items_availability:Dictionary[Game.INTERACTIVE_ITEM, bool]
@export var items_info:Dictionary[Game.INTERACTIVE_ITEM, Array]


func _ready() -> void:
	executed.connect(apply_act)


func apply_act():
	GameManager.items_availability_changed.emit(items_availability)
	GameManager.items_info_changed.emit(items_info)
