extends KinematicBody2D

var _speed := 100

func _process(delta):
	var direction := Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	elif Input.is_action_pressed("move_right"):
		direction.x += 1
	direction = direction.normalized()
	move_and_collide(direction * _speed * delta)

func _draw():
	var extents = $CollisionShape2D.shape.extents
	draw_rect(Rect2(-extents.x,-extents.y, extents.x*2, extents.y*2), Color.antiquewhite)

