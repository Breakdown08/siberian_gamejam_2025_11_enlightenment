extends Panel

@onready var id:Label = $id


func _ready() -> void:
	EventBus.scenario_id_updated.connect(
		func(scenario_id:int):
			id.text = str(scenario_id)
	)
