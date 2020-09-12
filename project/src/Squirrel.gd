extends KinematicBody2D
class_name Squirrel

var _base_speed : float
var _velocity := Vector2(1, 80)
export var speed := 10.0
export var max_speed := 30.0
export var speedmod := 1.1


func _ready():
	_base_speed = speed


func _process(delta):
	var collision := move_and_collide(_velocity * delta * speed)
	if collision:
		_velocity = _velocity.bounce(collision.normal)
		if collision.collider is Collectable:
			collision.collider.queue_free()
		if collision.collider is Trampoline and speed < max_speed:
			speed *= speedmod
			print(str(speed))
	update()
	
	
func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color.brown)


# Can be called when the game is over and the squirrel should stop in-place.
func stop():
	_velocity = Vector2.ZERO
