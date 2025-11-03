extends Control

@onready var actor_name:Label = $margin/body/tab/panel/actor_name
@onready var speech:Label = $margin/body/margin/speech
@onready var body:Panel = $margin/body
@onready var tab:HBoxContainer = $margin/body/tab
@onready var tab_panel:Panel = $margin/body/tab/panel

const ANIMATION_DURATION:float = 0.3

var style_box_flat:StyleBoxFlat


func _ready() -> void:
	hide()
	style_box_flat = body.get("theme_override_styles/panel") as StyleBoxFlat
	EventBus.dialog.connect(on_dialog)
	EventBus.dialog_continue.connect(on_dialog_continue)
	EventBus.thought.connect(on_thought)


func animation_update_text(actor_speech:String, hide_on_finished:bool=false):
	EventBus.speech_started.emit()
	speech.text = actor_speech
	speech.visible_ratio = 0.0
	var tween:Tween = Utils.tween(self, "dialog_speech")
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
	var tween:Tween = Utils.tween(self, "dialog")
	tween.tween_property(self, "scale", Vector2.ONE, ANIMATION_DURATION)
	tween.parallel().tween_property(self, "modulate", Color.WHITE, ANIMATION_DURATION)
	tween.tween_callback(func():
		animation_update_text(actor_speech, hide_on_finished)
	)


func animation_hide_dialog():
	var tween:Tween = Utils.tween(self, "dialog")
	tween.tween_interval(1.0)
	tween.tween_property(self, "scale", Vector2.ZERO, ANIMATION_DURATION)
	tween.parallel().tween_property(self, "modulate", Color.TRANSPARENT, ANIMATION_DURATION)
	tween.tween_callback(func():
		hide()
	)


func on_dialog(actor:String, actor_speech:String):
	animation_show_dialog(actor, actor_speech)


func on_dialog_continue(actor_speech:String):
	animation_update_text(actor_speech)


func on_thought(hero_speech:String):
	animation_show_dialog(Scenario.ACTOR_NONE, hero_speech, true)


func match_actor(actor:String):
	match actor:
		Scenario.ACTOR_HERO, Scenario.ACTOR_NONE:
			tab.alignment = BoxContainer.ALIGNMENT_BEGIN
			style_box_flat.corner_radius_top_left = 0
			style_box_flat.corner_radius_top_right = style_box_flat.corner_radius_bottom_left
			speech.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT 		
		_:
			tab.alignment = BoxContainer.ALIGNMENT_END
			style_box_flat.corner_radius_top_left = style_box_flat.corner_radius_bottom_left
			style_box_flat.corner_radius_top_right = 0
			speech.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
