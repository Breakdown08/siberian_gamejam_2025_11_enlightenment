class_name EncryptionMachineDisplay extends Control

@onready var symbols:Label = $symbols

const ANIMATION_DURATION:float = 3.0


func animation_result(result:String, animation_duration:float = 0.3):
	symbols.text = result
	symbols.position.x = size.x
	var tween:Tween = Utils.tween(self)
	tween.tween_property(symbols, "position:x", -symbols.size.x, animation_duration)


func animation_success_color():
	var tween:Tween = Utils.tween(self, "success_color")
	tween.tween_property(symbols, "self_modulate", Color.GREEN, 0.3)
	tween.tween_property(symbols, "self_modulate", Color.WHITE, 0.3)
	tween.tween_callback(func():
		animation_success_color()
	)


func on_switch_switched(symbol:String, state:bool):
	var result:String = generate_random_symbols()
	animation_result(result, Utils.get_visible_ratio_time(result) * 5)
	var tween:Tween = Utils.tween(self, "success_color")
	tween.tween_interval(0.1)
	symbols.self_modulate = Color.WHITE


func generate_random_symbols() -> String:
	var base:String = "!@#$%^&*()_+1234567890-="
	var result:String = ""
	randomize()
	for i in randi_range(6, 20):
		var random_symbol_id = randi_range(0, base.length() - 1)
		result += base[random_symbol_id]
	return result
