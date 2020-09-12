extends Control

onready var _squirrel := $Squirrel
onready var _trampoline := $Trampoline
onready var _game_timer := $GameTimer
onready var _game_timer_label := $GameTimerLabel
onready var _game_over_label := $GameOverLabel
onready var _collectables := $Collectables
onready var _score_label := $ScoreLabel
onready var _combo_label := $ComboLabel
var game_started := false
var points := 0
var _total_nuts := 0
var combo := 0

func _ready():
	var nuts:Array = _collectables.get_children()
	for item in nuts:
		if item is Collectable:
			item.connect("hit", self, "_collected_nut")
			_total_nuts += 1
		elif item is Birdfeeder:
			item.connect("hit", self, "_hit_birdfeeder")


func _process(_delta):
	_game_timer_label.text = str(ceil(_game_timer.time_left))
	_score_label.text = str(points)
	_combo_label.text = str(combo)
	if game_started and _total_nuts == 0:
		_game_over()
	elif not game_started:
		_squirrel.global_position.x = _trampoline.global_position.x
	

# Start the level (launch squirrel, start timer, etc)
func _start_level():
	_game_timer.start()
	_squirrel.start()


func _on_GameTimer_timeout():
	_game_over()


func _game_over():
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
	_total_nuts -= 1


func _hit_birdfeeder():
	combo += 1
	points += combo


func _on_Squirrel_reset_combo():
	combo = 0
