extends Control

func _ready():
	Jukebox.play_menu_song()

func _on_PlayButton_pressed():
	var _ignored = get_tree().change_scene("res://src/TestLevel.tscn")


func _on_FullscreenButton_pressed():
	GameStats.reset()
	OS.window_fullscreen = not OS.window_fullscreen


func _on_MuteMusicButton_toggled(button_pressed):
	if button_pressed:
		Jukebox.mute()
	else:
		Jukebox.unmute()
