extends InteractiveItem


#func _ready() -> void:
	#Scenario.photo_unlocked.connect(
		#func():
			#is_locked = false
	#)


#func on_new_thought(speech:String):
	#match GameManager.scenario_stage:
		#2:
			#if thought_id > 0:
				#Scenario.photo_unlocked.emit()
		#3:
			#if thought_id > 0:
				#Scenario.photo_unlocked.emit()
		#_:
			#prints(GameManager.scenario_stage)
			#pass
