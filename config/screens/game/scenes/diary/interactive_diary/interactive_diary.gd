class_name DiaryInteractiveItem extends InteractiveItem

var notes:Array[String] = []


func _ready() -> void:
	#Scenario.diary_unlocked.connect(
		#func():
			#is_locked = false
	#)
	Scenario.event.connect(on_scenario_event)


#func on_new_thought(speech:String):
	#match GameManager.scenario_stage:
		#1:
			#if thought_id > 0:
				#Scenario.diary_unlocked.emit()
		#_:
			#pass


func on_scenario_event(key:String, value:String):
	if key == "diary_note":
		notes.append(value)
