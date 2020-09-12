extends AudioStreamPlayer

var _gameplay_song = load("res://assets/music/squirrelsong.ogg")
var _menu_song = load("res://assets/music/menu.ogg")

onready var _music_bus_index := AudioServer.get_bus_index("Music")


func play_menu_song():
	stream = _menu_song
	play()
	

func play_gameplay_song():
	stream = _gameplay_song
	if not playing:
		play()


func mute():
	AudioServer.set_bus_mute(_music_bus_index, true)
	

func unmute():
	AudioServer.set_bus_mute(_music_bus_index, false)
