extends Control


func _on_PlayButton_pressed():
	var _ignored = get_tree().change_scene("res://src/TestLevel.tscn")


func _on_FullscreenButton_pressed():
	GameStats.reset()
	OS.window_fullscreen = not OS.window_fullscreen
