extends Node

onready var start_game_sound = $StartGame
onready var score_sound = $Score
onready var game_won_sound = $EndGame
onready var paddle_collision_sound = $PaddleCollision
onready var wall_collision_sound= $WallCollision


func stop_playing(audio: AudioStreamPlayer):
	if audio.playing:
		audio.stop()


func _on_Game_ball_rolling():
	start_game_sound.play()


func _on_Game_scored():
	score_sound.play()


func _on_Game_won(_player_name):
	game_won_sound.play()
	
	
func _on_Ball_paddle_collision():
	paddle_collision_sound.play()


func _on_Ball_wall_collision():
	wall_collision_sound.play()


func _on_Game_reseted():
	stop_playing(game_won_sound)
