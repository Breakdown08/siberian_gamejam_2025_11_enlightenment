extends InteractiveItem


func _ready() -> void:
	Scenario.diary_unlocked.connect(
		func():
			is_locked = false
	)


func on_new_thought(speech:String):
	match GameManager.scenario_stage:
		1:
			if thought_id > 0:
				Scenario.diary_unlocked.emit()
		_:
			pass
