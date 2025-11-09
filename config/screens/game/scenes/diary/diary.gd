extends Control

@onready var room:Button = $system_panel/margin/room
@onready var oscilloscope_params:DiaryNote = $main_notes/oscilloscope_params
@onready var radio_response:DiaryNote = $main_notes/radio_response
@onready var notes:VBoxContainer = $common_notes

const NOTE:PackedScene = preload("res://config/screens/game/scenes/diary/note/note.tscn")


func _ready() -> void:
	clear_notes()
	get_notes()
	room.pressed.connect(func(): GameManager.back_to_room.emit())


func clear_notes():
	for note in notes.get_children():
		note.queue_free()


func get_notes():
	var diary = GameManager.game.get_interactive_item(Game.INTERACTIVE_ITEM.DIARY) as DiaryInteractiveItem
	for note in diary.notes:
		var note_instance:DiaryNote = NOTE.instantiate()
		notes.add_child(note_instance)
		note_instance.key.text = str(note)
