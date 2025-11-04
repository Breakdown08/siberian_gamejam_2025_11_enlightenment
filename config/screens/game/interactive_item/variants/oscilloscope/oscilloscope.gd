extends InteractiveItem


func _ready() -> void:
	Scenario.oscilloscope_unlocked.connect(
		func():
			is_locked = false
	)


func on_new_thought(speech:String):
	match GameManager.scenario_stage:
		1:
			Scenario.oscilloscope_unlocked.emit()
		_:
			pass
