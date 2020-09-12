extends Control

onready var _squirrel := $Squirrel
onready var _game_timer := $GameTimer
onready var _game_timer_label := $GameTimerLabel
onready var _game_over_label := $GameOverLabel
var game_started := false

#func _ready():
#	# Later this will be started when the player taps or something.
#	# For now, just start the level on load.
#	_start_level()


func _process(_delta):
	_game_timer_label.text = str(ceil(_game_timer.time_left))
	

# Start the level (launch squirrel, start timer, etc)
func _start_level():
	_game_timer.start()
	_squirrel.start()


func _on_GameTimer_timeout():
	_game_over_label.visible = true
	_squirrel.stop()


func _input(event):
	if not game_started:
		if event is InputEventMouseButton or event is InputEventScreenTouch:
			_start_level()
			game_started = true
