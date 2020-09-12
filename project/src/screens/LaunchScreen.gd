extends Control

func _input(event):
	if event is InputEventMouseButton:
		var _ignored = get_tree().change_scene("res://src/screens/MenuScreen.tscn")
