extends KinematicBody2D
class_name Squirrel

var _base_speed : float
var _velocity := Vector2.ZERO
export var speed := 10.0
export var max_speed := 30.0
export var speedmod := 1.1
onready var _hit_wall := $Wall
onready var _hit_nut := $Nut
onready var _hit_trampoline := $Trampoline
onready var _hit_birdfeeder:= $Birdfeeder

signal reset_combo

func _ready():
	_base_speed = speed


func _process(delta):
	var collision := move_and_collide(_velocity * delta * speed)
	if collision:
		_velocity = _velocity.bounce(collision.normal)
		if collision.collider is Collectable:
			collision.collider.hit()
			_hit_nut.play()
		if collision.collider is Trampoline and speed < max_speed:
			speed *= speedmod
			emit_signal("reset_combo")
			_hit_trampoline.play()
		if collision.collider is Birdfeeder:
			collision.collider.hit()
			_hit_birdfeeder.play()
		else:
			_hit_wall.play()
	update()


# Can be called when the game is over and the squirrel should stop in-place.
func stop():
	_velocity = Vector2.ZERO

func start():
	_velocity.y = -80
