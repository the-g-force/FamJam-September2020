extends StaticBody2D
class_name Collectable

signal hit


func hit():
	emit_signal("hit")
	queue_free()
