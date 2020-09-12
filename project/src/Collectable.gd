extends StaticBody2D
class_name Collectable

func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color.azure)
