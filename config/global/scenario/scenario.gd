extends Node

const CONFIG:PackedScene = preload("res://scenario.tscn")

var skeleton:ScenarioSkeleton
var database:ScenarioDatabase
var actors:Node

signal event(key:String, value:String)
signal next_action(next_cursor:ScenarioSkeletonAction)
signal speech(actor:Actor, text:String)
signal act_started(act:Act)
signal cutscene_started
signal cutscene_finished
signal speech_started
signal speech_finished


func _ready() -> void:
	var config = CONFIG.instantiate()
	config.name = "config"
	add_child(config)
	skeleton = config.get_node("skeleton")
	database = config.get_node("database")
	actors = config.get_node("actors")


func create_event(scenario_event:ScenarioEvent):
	event.emit(scenario_event.key, scenario_event.value)
	prints("[SCENARIO] event: %s, description: %s" % [scenario_event.name, scenario_event.description])


func get_actor(actor:String) -> Actor:
	if actors.has_node(actor):
		return actors.get_node(actor)
	else:
		push_error("ScenarioActors get actor error '%s'" % actor)
		return null
