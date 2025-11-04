extends Control

@onready var actor_name:Label = $margin/body/tab/panel/actor_name
@onready var speech:Label = $margin/body/margin/speech
@onready var body:Panel = $margin/body
@onready var tab:HBoxContainer = $margin/body/tab
@onready var tab_panel:Panel = $margin/body/tab/panel

const ANIMATION_DURATION:float = 0.3
const HIDE_INTERVAL:float = 3.0

var style_box_flat:StyleBoxFlat


func _ready() -> void:
	hide()
	body.self_modulate = Color("5c5c6194")
	style_box_flat = body.get("theme_override_styles/panel") as StyleBoxFlat
	EventBus.dialog.connect(on_dialog)
	EventBus.thought.connect(on_thought)
	Scenario.cutscene_off.connect(animation_hide_dialog)


func animation_update_text(actor_speech:String, hide_on_finished:bool=false):
	EventBus.speech_started.emit()
	speech.text = actor_speech
	speech.visible_ratio = 0.0
	var tween:Tween = Utils.tween(self, "update")
	tween.tween_property(speech, "visible_ratio", 1.0, Utils.get_visible_ratio_time(actor_speech) / 3)
	tween.tween_callback(func():
		EventBus.speech_finished.emit()
		if hide_on_finished:
			animation_hide_dialog()
	)


func animation_show_dialog(actor:String, actor_speech:String, hide_on_finished:bool=false):
	EventBus.speech_started.emit()
	match_actor(actor)
	show()
	speech.text = ""
	actor_name.text = actor
	modulate = Color.TRANSPARENT
	scale = Vector2.ZERO
	var tween:Tween = Utils.tween(self, "visible")
	tween.tween_property(self, "scale", Vector2.ONE, ANIMATION_DURATION)
	tween.parallel().tween_property(self, "modulate", Color.WHITE, ANIMATION_DURATION)
	tween.tween_callback(func():
		animation_update_text(actor_speech, hide_on_finished)
	)


func animation_hide_dialog():
	var tween:Tween = Utils.tween(self, "visible")
	tween.tween_interval(HIDE_INTERVAL)
	tween.tween_property(self, "scale", Vector2.ZERO, ANIMATION_DURATION)
	tween.parallel().tween_property(self, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.tween_callback(func():
		hide()
	)


func on_dialog(actor:String, actor_speech:String):
	if visible:
		if GameManager.current_actor == actor:
			animation_update_text(actor_speech)
		else:
			animation_show_dialog(actor, actor_speech)
	else:
		animation_show_dialog(actor, actor_speech)


func on_thought(hero_speech:String):
	animation_show_dialog(Scenario.ACTOR_NONE, hero_speech, true)


func match_actor(actor:String):
	match actor:
		Scenario.ACTOR_HERO:
			tab_panel.self_modulate = Color("4cb072")
		Scenario.ACTOR_NONE:
			tab_panel.self_modulate = Color("33abb8ff")
		Scenario.ACTOR_FRIEND:
			tab_panel.self_modulate = Color("0ea2f1ff")
