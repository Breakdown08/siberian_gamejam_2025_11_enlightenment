extends InteractiveItem

@export var oscilloscope:OscilloscopeInteractiveItem


#func _ready() -> void:
	#Scenario.computer_unlocked.connect(
		#func():
			#is_locked = false
	#)


#func on_new_thought(speech:String):
	#match GameManager.scenario_stage:
		#1:
			#if GameManager.oscilloscope_params.is_empty():
				#return
			#Scenario.computer_unlocked.emit()
		#_:
			#pass
