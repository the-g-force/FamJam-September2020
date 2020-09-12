extends StaticBody2D
class_name Collectable

signal hit

func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color.azure)


func hit():
	emit_signal("hit")
	queue_free()
