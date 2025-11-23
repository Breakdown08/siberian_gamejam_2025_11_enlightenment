class_name EncryptionMachine extends Control

@onready var switches:Array[Node] = $switches.get_children()
@onready var display:EncryptionMachineDisplay = $display
@onready var input:EncryptionMachineInput = $input
@onready var room:Button = $system_panel/margin/room
@onready var reset:Button = $reset
@onready var accept:Button = $accept


func _ready() -> void:
	room.pressed.connect(GameManager.back_to_room.emit)
	reset.pressed.connect(input.on_reset)
	accept.pressed.connect(on_accept)
	for item in switches:
		var switch = item as EncryptionMachineSwitch
		switch.switched.connect(display.on_switch_switched)
		switch.switched.connect(input.on_switch_switched)
		reset.pressed.connect(switch._ready)


func on_accept(key:String = input.display.text):
	if key.to_upper() == Scenario.database.get_key("encryption_machine_password").to_upper():
		var result = Scenario.database.get_key("encryption_machine_answer")
		display.animation_result(result, Utils.get_visible_ratio_time(result) * 5)
		display.animation_success_color()
		if GameManager.game:
			Scenario.next()
