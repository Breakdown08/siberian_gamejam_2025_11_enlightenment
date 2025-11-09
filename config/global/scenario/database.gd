class_name ScenarioDatabase extends Node

@export var scenario_keys:Dictionary[String, String]


func get_key(key:String) -> String:
	if scenario_keys.has(key):
		return scenario_keys.get(key)
	else:
		push_error("ScenarioDatabase get key error '%s'" % key)
		return ""
