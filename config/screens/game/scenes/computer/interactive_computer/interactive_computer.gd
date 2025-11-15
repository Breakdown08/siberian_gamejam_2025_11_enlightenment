class_name ComputerInteractiveItem extends InteractiveItem

@export var oscilloscope:OscilloscopeInteractiveItem

signal radio_response_updated(new_response:String)

var radio_response:String = ""


func update_radio_response(new_response:String):
	radio_response = new_response
	radio_response_updated.emit(radio_response)
	GameManager.on_scenario_event("diary_updated")
