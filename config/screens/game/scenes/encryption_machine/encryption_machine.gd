class_name EncryptionMachine extends Control

@onready var switches:Array[Node] = $switches.get_children()
@onready var display:EncryptionMachineDisplay = $display
@onready var input:EncryptionMachineInput = $input
@onready var room:Button = $system_panel/margin/room
@onready var reset:Button = $reset
@onready var accept:Button = $accept


func _ready() -> void:
	Scenario.encryption_machine_try_code_breaking.connect(on_encryption_machine_try_code_breaking)
	room.pressed.connect(_on_room_pressed)
	reset.pressed.connect(input.on_reset)
	accept.pressed.connect(input.on_accept)
	for item in switches:
		var switch = item as EncryptionMachineSwitch
		switch.switched.connect(display.on_switch_switched)
		switch.switched.connect(input.on_switch_switched)
		reset.pressed.connect(switch._ready)


func _on_room_pressed():
	EventBus.scene_switched.emit(Game.SCENE.MAIN)


func on_encryption_machine_try_code_breaking(key:String):
	if key.to_upper() == Scenario.ENCRYPTION_MACHINE_PASSWORD.to_upper():
		var result = Scenario.ENCRYPTION_MACHINE_ANSWER
		display.animation_result(result, Utils.get_visible_ratio_time(result) * 5)
		display.animation_success_color()
