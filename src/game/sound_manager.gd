extends Node

onready var start_game_sound = $StartGame
onready var score_sound = $Score
onready var game_won_sound = $EndGame
onready var paddle_collision_sound = $PaddleCollision
onready var wall_collision_sound= $WallCollision


func stop_playing(audio):
	audio.stream_paused = true
	audio.stop()


func _on_Game_ball_rolling():
	start_game_sound.play()


func _on_Goal_body_entered(_body):
		score_sound.play()


func _on_Game_won(player_name):
	stop_playing(score_sound)
	game_won_sound.play()
	
	
func _on_Ball_paddle_collision():
	paddle_collision_sound.play()


func _on_Ball_wall_collision():
	wall_collision_sound.play()
