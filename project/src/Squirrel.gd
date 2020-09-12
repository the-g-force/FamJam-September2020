extends KinematicBody2D

var _velocity := Vector2(10, 800)

func _process(delta):
	var collision := move_and_collide(_velocity * delta)
	if collision:
		_velocity = _velocity.bounce(collision.normal)
	update()

func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color.brown)
