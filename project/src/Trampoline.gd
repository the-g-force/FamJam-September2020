extends KinematicBody2D
class_name Trampoline

# Number of pixels around touch point that count as being there
export var touch_tolerance := 10.0
# How fast it goes with keyboard input
export var speed := 200.0

var enabled := true

var _is_touch_down := false
var _touch_position : Vector2

onready var Y_POSITION := position.y

func _process(delta):
	if not enabled:
		return
	
	# Handle keyboard input
	var direction := Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	direction = direction.normalized()
	var collision := move_and_collide(direction * speed * delta)
	if collision:
		if collision.collider is Squirrel:
			var _squirrel = collision.collider
			if _squirrel.on_ground:
				_squirrel.global_position.y -= 50
				_squirrel.start()
			# Always reset Y location, since it can get bobbled on a collision
			position = Vector2(position.x, Y_POSITION)
				
	
	# Handle touch input.
	if _is_touch_down:
		global_position = Vector2(_touch_position.x, global_position.y)
		

func _input(event):
	if not enabled:
		return
	if event is InputEventMouseButton:
		if event.pressed:
			_is_touch_down = true
			_touch_position = event.position
		else:
			_is_touch_down = false
	elif _is_touch_down and event is InputEventMouseMotion:
		_touch_position = event.position
