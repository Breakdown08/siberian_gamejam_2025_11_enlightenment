extends Node

@onready var music_player:AudioStreamPlayer
@onready var sfx_player:AudioStreamPlayer

var music_volume:float = 15
var sfx_volume:float = 15
var multiplier: float = 10


func play_music():
	music_player.volume_db = linear_to_db(music_volume / multiplier)
	music_player.play()
	music_player.finished.connect(func():
		music_player.play()
	)

func play_sfx(stream:AudioStream):
	sfx_player.stream = stream
	sfx_player.volume_db = linear_to_db(sfx_volume / multiplier)
	sfx_player.play()
	
func update_volumes():
	music_player.volume_db = linear_to_db(music_volume / multiplier)
	sfx_player.volume_db = linear_to_db(sfx_volume / multiplier)
