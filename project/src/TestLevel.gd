extends Control

onready var _squirrel := $Squirrel
onready var _game_timer := $GameTimer
onready var _game_timer_label := $GameTimerLabel
onready var _game_over_label := $GameOverLabel
onready var _collectables := $Collectables
onready var _score_label := $ScoreLabel
onready var _combo_label := $ComboLabel
var game_started := false
var points := 0
var combo := 0

func _ready():
	var nuts:Array = _collectables.get_children()
	for item in nuts:
		if item is Collectable:
			item.connect("hit", self, "_collected_nut")


func _process(_delta):
	_game_timer_label.text = str(ceil(_game_timer.time_left))
	_score_label.text = str(points)
	_combo_label.text = str(combo)
	

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


func _collected_nut():
	combo += 1
	points += combo
	

func _on_Squirrel_reset_combo():
	combo = 0
