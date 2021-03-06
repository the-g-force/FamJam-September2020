extends Control

# The number of seconds a regular game lasts at level 1
export var base_duration := 20
export var margin := 20

var _game_started := false
var _total_nuts := 0
var combo := 1

onready var _squirrel := $Squirrel
onready var _trampoline := $Trampoline
onready var _collectables := $Collectables
onready var _game_timer := $GameTimer
onready var _game_timer_label := $UI/Top/GameTimerLabel
onready var _level_complete_ui := $UI/LevelCompleteUI
onready var _score_label := $UI/Top/ScoreLabel
onready var _combo_label := $UI/Top/ComboLabel
onready var _game_over_ui := $UI/GameOverUI
onready var _game_over_label := $UI/GameOverUI/GameOverLabel
onready var Nut := preload("res://src/Collectable.tscn")
onready var Feeder := preload("res://src/Birdfeeder.tscn")

func _ready():
	randomize()
	# Determine how long we have to complete this level
	_game_timer.wait_time = base_duration - (GameStats.level-1) * 2
	
	Jukebox.play_gameplay_song()
	var allthenuts = 4+randi()%2
	var allthefeeders = 1+randi()%2
	for _x in allthenuts:
		var nut = Nut.instance()
		var x = rand_range(margin,600-margin)
		var y = rand_range(margin,512)
		var position = Vector2(x,y)
		nut.position = position
		_collectables.add_child(nut)
	for _x in allthefeeders:
		var feeder = Feeder.instance()
		var x = rand_range(margin,600-margin)
		var y = rand_range(margin,512)
		var position = Vector2(x,y)
		feeder.position = position
		_collectables.add_child(feeder)
	
	var nuts:Array = _collectables.get_children()
	var nut_type := randi()%2
	for item in nuts:
		if item is Collectable:
			item.connect("hit", self, "_collected_nut")
			_total_nuts += 1
			item.sprite.play(str(nut_type))
		elif item is Birdfeeder:
			item.connect("hit", self, "_hit_birdfeeder")


func _process(_delta):
	_game_timer_label.text = str(ceil(\
		_game_timer.time_left if _game_started else _game_timer.wait_time \
	))
	_score_label.text = str(GameStats.score)
	_combo_label.text = str(combo) + "X"
	if _game_started and _total_nuts == 0:
		_handle_level_clear()
	elif not _game_started:
		_squirrel.global_position.x = _trampoline.global_position.x
	

# Start the level (launch squirrel, start timer, etc)
func _start_level():
	_game_timer.start()
	_squirrel.start()


func _on_GameTimer_timeout():
	_game_over()


func _handle_level_clear():
	_stop_gameplay()
	_level_complete_ui.visible = true


func _stop_gameplay():
	_game_timer.set_paused(true)
	_squirrel.stop()
	_trampoline.enabled = false

func _game_over():
	_stop_gameplay()
	_game_over_label.text = "Winter is here!\n\nScore: %d" % GameStats.score
	_game_over_ui.visible = true


func _input(event):
	if not _game_started:
		if event is InputEventMouseButton or event is InputEventScreenTouch:
			_start_level()
			_game_started = true


func _collected_nut():
	GameStats.score += 10*combo
	combo += 1
	GameStats.nuts += 1
	_total_nuts -= 1


func _hit_birdfeeder():
	GameStats.score += 10*combo
	GameStats.nuts += 1


func _on_Squirrel_reset_combo():
	combo = 1


func _on_NextLevelButton_pressed():
	GameStats.level += 1
	var _ignored = get_tree().change_scene("res://src/TestLevel.tscn")


func _on_MainMenuButton_pressed():
	GameStats.reset()
	var _ignored = get_tree().change_scene("res://src/screens/MenuScreen.tscn")
