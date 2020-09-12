extends KinematicBody2D
class_name Squirrel

export var speed := 10.0
export var max_speed := 30.0
export var speedmod := 1.1

var _base_speed : float
var _velocity := Vector2.ZERO
var _spin := 0.0


onready var _hit_wall := $Wall
onready var _hit_nut := $Nut
onready var _hit_trampoline := $Trampoline
onready var _hit_birdfeeder:= $Birdfeeder

signal reset_combo

func _ready():
	_base_speed = speed


func _process(delta):
	rotation += _spin * delta
	
	var collision := move_and_collide(_velocity * delta * speed)
	if collision:
		_velocity = _velocity.bounce(collision.normal)
		_spin += rand_range(-1, 1)
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
	_spin = 0

func start():
	var max_angle = deg2rad(30)
	var angle = rand_range(-max_angle, max_angle)
	_velocity = Vector2(0,-80).rotated(angle)
