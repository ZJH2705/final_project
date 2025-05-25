extends Node

var sound_on := true
@onready var player = $MusicPlayer

func play_music():
	if Keep.sound_enabled and not player.playing:
		player.play()

func stop_music():
	player.stop()

func is_playing() -> bool:
	return player.playing
