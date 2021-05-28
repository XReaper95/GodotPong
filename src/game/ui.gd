extends Node

export(Resource) var player_data
export (String, MULTILINE) var game_begin_text = ""
export (String, MULTILINE) var reset_text = ""

# Players
onready var LeftPlayerName = $HTopContainer/LeftPlayerMargin/PlayerBoard/PlayerName
onready var LeftPlayerScore = $HTopContainer/LeftPlayerMargin/PlayerBoard/PlayerScore

onready var RightPlayerName = $HTopContainer/RightPlayerMargin/PlayerBoard/PlayerName
onready var RightPlayerScore = $HTopContainer/RightPlayerMargin/PlayerBoard/PlayerScore

# Text
onready var MaxRoundsText = $HTopContainer/GameRoundsMargin/MaxRounds
onready var WonText = $CenterMargin/WonText
onready var BottomText = $BottomMargin/BottomText
onready var initial_won_text: String = WonText.text
onready var initial_won_text_color = WonText.get_color("font_color")

var is_game_started = false
var _p_data: PlayerData


func reset():
	WonText.text = initial_won_text
	WonText.add_color_override("font_color", initial_won_text_color)
	WonText.hide()
	BottomText.text = game_begin_text
	

func _ready():
	_p_data = player_data
	LeftPlayerName.text = _p_data.left_player_name
	RightPlayerName.text = _p_data.right_player_name
	MaxRoundsText.text = MaxRoundsText.text % _p_data.max_score  # TODO max
	WonText.hide()
	BottomText.text = game_begin_text
	
	
func _on_Game_ball_rolling():
	if not is_game_started:
		is_game_started = true
		BottomText.hide()


func _on_Game_won(player_name):
	var won_color
	
	if player_name == LeftPlayerName.text:
		won_color = LeftPlayerName.get_color("font_color")
	else:
		won_color = RightPlayerName.get_color("font_color")
	
	WonText.add_color_override("font_color", won_color)
	var current_won_text = WonText.text
	WonText.text = current_won_text % player_name	
	WonText.show()
	BottomText.text = reset_text
	BottomText.show()


func _on_Game_score_changed(player_name, score):
	var player_ref
	
	if player_name == _p_data.left_player_name:
		player_ref = LeftPlayerScore
	else:
		player_ref = RightPlayerScore
		
	player_ref.text = str(score)


func _on_Game_reseted():
	reset()
