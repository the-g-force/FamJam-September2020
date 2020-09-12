extends AudioStreamPlayer

onready var _music_bus_index := AudioServer.get_bus_index("Music")


func play_gamplay_song():
	if not playing:
		play()


func mute():
	AudioServer.set_bus_mute(_music_bus_index, true)
	

func unmute():
	AudioServer.set_bus_mute(_music_bus_index, false)
