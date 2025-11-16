class_name OscilloscopeInteractiveItem extends InteractiveItem

signal params_updated(new_params:String)

var last_selected_curve_path:String = ""
var params:String = ""


func update_params(curve:TextureRect):
	last_selected_curve_path = curve.get_path()
	params = str(curve.name.hash())
	params_updated.emit(params)
	GameManager.on_scenario_event("diary_updated")
