extends Control

@onready var actor_name:Label = $margin/body/tab/panel/actor_name
@onready var speech:Label = $margin/body/margin/speech
@onready var body:Panel = $margin/body
@onready var tab:HBoxContainer = $margin/body/tab
@onready var tab_panel:Panel = $margin/body/tab/panel

const ANIMATION_DURATION:float = 0.3
const HIDE_INTERVAL:float = 3.0

var style_box_flat:StyleBoxFlat

var actor_hero:Actor = Scenario.actors.get_node("hero")
var actor_friend:Actor = Scenario.actors.get_node("friend")
var actor_none:Actor = Scenario.actors.get_node("none")


func _ready() -> void:
	hide()
	body.self_modulate = Color("5c5c6194")
	style_box_flat = body.get("theme_override_styles/panel") as StyleBoxFlat
	Scenario.speech.connect(on_speech)
	Scenario.cutscene_finished.connect(func():animation_hide_dialog(true))
	GameManager.item_info.connect(on_item_info)


func animation_update_text(actor_speech:String, hide_on_finished:bool=false):
	Scenario.speech_started.emit()
	speech.text = actor_speech
	speech.visible_ratio = 0.0
	var tween:Tween = Utils.tween(self, "update")
	tween.tween_property(speech, "visible_ratio", 1.0, Utils.get_visible_ratio_time(actor_speech) / 3)
	tween.tween_callback(func():
		Scenario.speech_finished.emit()
		if Scenario.is_stopped or hide_on_finished:
			animation_hide_dialog()
	)


func animation_show_dialog(actor:Actor, actor_speech:String, hide_on_finished:bool=false):
	Scenario.speech_started.emit()
	match_actor(actor)
	show()
	speech.text = ""
	actor_name.text = actor.actor_name
	modulate = Color.TRANSPARENT
	scale = Vector2.ZERO
	var tween:Tween = Utils.tween(self, "visible")
	tween.tween_property(self, "scale", Vector2.ONE, ANIMATION_DURATION)
	tween.parallel().tween_property(self, "modulate", Color.WHITE, ANIMATION_DURATION)
	tween.tween_callback(func():
		animation_update_text(actor_speech, hide_on_finished)
	)


func animation_hide_dialog(fast:bool = false):
	var tween:Tween = Utils.tween(self, "visible")
	if !fast:
		tween.tween_interval(HIDE_INTERVAL)
	tween.tween_property(self, "scale", Vector2.ZERO, ANIMATION_DURATION)
	tween.parallel().tween_property(self, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.tween_callback(func():
		hide()
	)


func on_speech(actor:Actor, text:String):
	prints("		[SCENARIO] '%s' - %s" % [actor.actor_name, text])
	if visible:
		if GameManager.current_actor == actor:
			animation_update_text(text)
		else:
			animation_show_dialog(actor, text)
	else:
		animation_show_dialog(actor, text)


func on_item_info(hero_speech:String):
	animation_show_dialog(actor_none, hero_speech, true)


func match_actor(actor:Actor):
	match actor:
		actor_hero:
			tab_panel.self_modulate = Color("4cb072")
		actor_none:
			tab_panel.self_modulate = Color("33abb8ff")
		actor_friend:
			tab_panel.self_modulate = Color("0ea2f1ff")
