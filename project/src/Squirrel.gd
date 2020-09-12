extends KinematicBody2D
class_name Squirrel

var _base_speed : float
var _velocity := Vector2.ZERO
export var speed := 10.0
export var max_speed := 30.0
export var speedmod := 1.1

signal reset_combo

func _ready():
	_base_speed = speed


func _process(delta):
	var collision := move_and_collide(_velocity * delta * speed)
	if collision:
		_velocity = _velocity.bounce(collision.normal)
		if collision.collider is Collectable:
			collision.collider.hit()
		if collision.collider is Trampoline and speed < max_speed:
			speed *= speedmod
			emit_signal("reset_combo")
	update()
	
	
func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color.brown)


# Can be called when the game is over and the squirrel should stop in-place.
func stop():
	_velocity = Vector2.ZERO

func start():
	_velocity.y = -80
