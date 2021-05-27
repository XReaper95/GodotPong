extends Node

signal ball_rolling
signal won(player_name)
signal score_changed(player_name, score)

export var max_score = 1
export var left_name = "Player"
export var right_name = "Oponent"

onready var BallTimer = $BallTimer
onready var Ball = $Field/Ball

var left_score = 0
var right_score = 0
var is_ball_rolling = false
var is_game_ended = false

func process_score(score, name):
	score += 1
	
	if score >= max_score:
		emit_signal("won", name)
		is_game_ended = true
		
	return score


func _process(_delta):
	if Input.is_action_just_pressed("game_run") and \
		not is_ball_rolling and not is_game_ended:
			
		is_ball_rolling = true
		emit_signal("ball_rolling")


func _on_LeftGoal_body_entered(_body):
	BallTimer.start()
	right_score = process_score(right_score, right_name)


func _on_RightGoal_body_entered(_body):
	BallTimer.start()
	left_score = process_score(left_score, left_name)


func _on_BallTimer_timeout():
	Ball.reset_pos()
	is_ball_rolling = false
