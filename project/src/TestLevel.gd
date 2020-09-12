extends Control

onready var _squirrel := $Squirrel
onready var _game_timer := $GameTimer
onready var _game_timer_label := $GameTimerLabel
onready var _game_over_label := $GameOverLabel

func _ready():
	# Later this will be started when the player taps or something.
	# For now, just start the level on load.
	_start_level()


func _process(_delta):
	_game_timer_label.text = str(ceil(_game_timer.time_left))
	

# Start the level (launch squirrel, start timer, etc)
func _start_level():
	_game_timer.start()


func _on_GameTimer_timeout():
	_game_over_label.visible = true
	_squirrel._velocity = Vector2.ZERO # Replace with function call!
