extends Node

signal ball_rolling
signal ball_reseted
signal reseted
signal scored
signal won(player_name)
signal score_changed(player_name, score)

export(Resource) var player_data

onready var BallTimer = $BallTimer

var left_name = ""
var right_name = ""
var max_score = 0
var left_score = 0
var right_score = 0
var is_ball_rolling = false
var is_game_ended = false

var _p_data: PlayerData


func _ready():
	_p_data = player_data
	left_name = _p_data.left_player_name
	right_name = _p_data.right_player_name
	max_score = _p_data.max_score


func reset():
	left_score = 0
	right_score = 0
	emit_signal("score_changed", left_name, left_score)
	emit_signal("score_changed", right_name, right_score)
	is_ball_rolling = false
	is_game_ended = false
	emit_signal("reseted")
	

func process_score(score, name):
	score += 1
	
	if score >= max_score:
		emit_signal("won", name)
		is_game_ended = true
	else:
		emit_signal("scored")
		
	return score


func roll_ball():
	is_ball_rolling = true
	emit_signal("ball_rolling")


func _process(_delta):
	if Input.is_action_just_pressed("game_run") and \
		not is_ball_rolling and not is_game_ended:
			roll_ball()
	
	if Input.is_action_just_pressed("game_run") and is_game_ended:
		reset()
		
	if Input.is_action_just_pressed("game_exit"):
		get_tree().quit()


func _on_LeftGoal_body_entered(_body):
	right_score = process_score(right_score, right_name)
	emit_signal("score_changed", right_name, right_score)
	if not is_game_ended:
		BallTimer.start()


func _on_RightGoal_body_entered(_body):
	left_score = process_score(left_score, left_name)
	emit_signal("score_changed", left_name, left_score)
	if not is_game_ended:
		BallTimer.start()


func _on_BallTimer_timeout():
	emit_signal("ball_reseted")
	is_ball_rolling = false
