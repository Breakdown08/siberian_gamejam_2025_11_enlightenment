extends Panel

@onready var id:Label = $id
@onready var next_scenario_indicator:Panel = $next_scenario_indicator


func _ready() -> void:
	EventBus.scenario_id_updated.connect(
		func(scenario_id:int):
			id.text = str(scenario_id)
	)
	EventBus.speech_finished.connect(func():
		next_scenario_indicator.modulate = Color.GREEN
	)
	EventBus.speech_started.connect(func():
		next_scenario_indicator.modulate = Color.RED
	)
