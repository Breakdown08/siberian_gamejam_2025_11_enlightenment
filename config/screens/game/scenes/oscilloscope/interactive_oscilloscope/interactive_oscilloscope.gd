class_name OscilloscopeInteractiveItem extends InteractiveItem

var params:String


#func on_new_thought(speech:String):
	#match GameManager.scenario_stage:
		#1:
			#Scenario.oscilloscope_unlocked.emit()
		#_:
			#pass


func update_params(new_params:String):
	params = new_params
