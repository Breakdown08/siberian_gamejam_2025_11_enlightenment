extends Control

@onready var title:Label = $margin/body/title

var timestamp:int = 0


func _ready() -> void:
	title.text = _timestamp_to_string()


func _timestamp_to_string() -> String:
	var dt = Time.get_datetime_dict_from_unix_time(timestamp)
	dt.hour += 3
	var unix_msk = Time.get_unix_time_from_datetime_dict(dt)
	dt = Time.get_datetime_dict_from_unix_time(unix_msk)
	return "%02d.%02d.%04d - %02d:%02d" % [
		dt.day, dt.month, dt.year,
		dt.hour, dt.minute
	]
