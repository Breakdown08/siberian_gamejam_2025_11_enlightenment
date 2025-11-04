extends InteractiveItem


func _ready() -> void:
	Scenario.glasses_unlocked.connect(
		func():
			is_locked = false
	)


func on_new_thought(speech:String):
	prints(GameManager.scenario_stage)
	match GameManager.scenario_stage:
		4:
			if thought_id == 0:
				Scenario.glasses_unlocked.emit()
		_:
			prints(GameManager.scenario_stage)
			pass
