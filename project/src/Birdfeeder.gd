extends StaticBody2D
class_name Birdfeeder

signal hit


func _draw():
	draw_rect(Rect2(Vector2.ZERO, $CollisionShape2D.shape.extents), Color.cornsilk)


func hit():
	emit_signal("hit")



