class_name ActorSpeech extends ScenarioSkeletonAction

@export var actor:Actor
@export var speech:Array[String]

var speech_id:int = -1


func _ready() -> void:
	speech_id = -1


func _execute():
	prints("		[SCENARIO] executing actor %s speech" % name)
	Scenario.log_history("[РЕЧЬ]: '%s'" % actor.actor_name)
	if Scenario.skeleton.cursor != null:
		if Scenario.skeleton.cursor == self and Scenario.is_reading_finished:
			phrase()


func phrase():
	speech_id = speech_id + 1 if speech_id < speech.size() - 1 else -1
	if speech_id == -1:
		executed.emit()
		return
	Scenario.log_history("	- %s" % speech[speech_id])
	Scenario.reading_started.emit()
	Scenario.speech.emit(actor, speech[speech_id])
