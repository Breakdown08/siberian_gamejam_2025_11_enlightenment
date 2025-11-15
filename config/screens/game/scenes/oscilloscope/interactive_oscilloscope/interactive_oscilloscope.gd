class_name OscilloscopeInteractiveItem extends InteractiveItem

signal params_updated(new_params:TextureRect)

var params:TextureRect


func update_params(new_params:TextureRect):
	params = new_params
	params_updated.emit(params)
	GameManager.on_scenario_event("diary_updated")
