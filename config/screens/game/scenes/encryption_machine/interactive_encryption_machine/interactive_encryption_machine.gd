extends InteractiveItem


#func _ready() -> void:
	#Scenario.photo_unlocked.connect(
		#func():
			#is_locked = false
	#)


#func on_new_thought(speech:String):
	#match GameManager.scenario_stage:
		#3:
			#if thought_id > 0:
				#Scenario.encryption_machine_unlocked.emit()
		#_:
			#prints(GameManager.scenario_stage)
			#pass
