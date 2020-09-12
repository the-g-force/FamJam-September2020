extends KinematicBody2D

# Number of pixels around touch point that count as being there
export var touch_tolerance := 10.0

var _speed := 200
var _is_touch_down := false
var _touch_position : Vector2

func _process(delta):
	var direction := Vector2.ZERO
	
	# Handle keyboard input
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	# Handle touch input.
	if _is_touch_down:
		var distance_to_touch := _touch_position - get_global_transform_with_canvas().origin 
		if distance_to_touch.x < -touch_tolerance:
			direction.x -= 1
		elif distance_to_touch.x > touch_tolerance:
			direction.x += 1
		
	direction = direction.normalized()
	var _ignored_result := move_and_collide(direction * _speed * delta)
	


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			_is_touch_down = true
			_touch_position = event.position
		else:
			_is_touch_down = false
	elif _is_touch_down and event is InputEventMouseMotion:
		_touch_position = event.position


func _draw():
	var extents = $CollisionShape2D.shape.extents
	draw_rect(Rect2(-extents.x,-extents.y, extents.x*2, extents.y*2), Color.antiquewhite)

