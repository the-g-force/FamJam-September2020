extends StaticBody2D
class_name Collectable

onready var sprite : AnimatedSprite = $Sprite

signal hit


func hit():
	emit_signal("hit")
	queue_free()
