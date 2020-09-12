extends Control


func _on_PlayButton_pressed():
	var _ignored = get_tree().change_scene("res://src/TestLevel.tscn")


func _on_FullscreenButton_pressed():
	OS.window_fullscreen = not OS.window_fullscreen
