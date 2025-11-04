extends InteractiveItem


func _ready() -> void:
	is_locked = true
	Scenario.morse_unlocked.connect(func():
		is_locked = false
	)
	Scenario.encryption_machine_success.connect( func():
		is_locked = true
	)


func on_new_thought(speech:String):
	prints(thought_id)
	match GameManager.scenario_stage:
		2:
			if thought_id == 0:
				Scenario.morse_unlocked.emit()
		_:
			pass
