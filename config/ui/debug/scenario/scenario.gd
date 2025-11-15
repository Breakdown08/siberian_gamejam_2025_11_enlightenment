extends Panel

@onready var id:Label = $id
@onready var next_scenario_indicator:Panel = $next_scenario_indicator


func _ready() -> void:
	#ScenarioNew.next_action.connect(
		#func(next_cursor:ScenarioSkeletonAction):
			#if next_cursor != null:
				#id.text = str(next_cursor.name) + " " + str(GameManager.act.number)
	#)
	Scenario.speech_finished.connect(func():
		next_scenario_indicator.modulate = Color.GREEN
	)
	Scenario.speech_started.connect(func():
		next_scenario_indicator.modulate = Color.RED
	)
