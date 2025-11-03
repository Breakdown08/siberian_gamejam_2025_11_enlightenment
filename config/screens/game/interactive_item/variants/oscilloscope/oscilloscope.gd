extends InteractiveItem


func on_new_thought(speech:String):
	match GameManager.scenario_stage:
		1:
			pass
		_:
			pass
