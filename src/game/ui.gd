extends Node

export (String) var game_begin_text = ""
export (String) var reset_text = ""

# Players
onready var LeftPlayerName = $HTopContainer/LeftPlayerMargin/PlayerBoard/PlayerName
onready var LeftPlayerScore = $HTopContainer/LeftPlayerMargin/PlayerBoard/PlayerScore

onready var RightPlayerName = $HTopContainer/RightPlayerMargin/PlayerBoard/PlayerName
onready var RIghtPlayerScore = $HTopContainer/RightPlayerMargin/PlayerBoard/PlayerScore

# Text
onready var MaxRoundsText = $HTopContainer/GameRoundsMargin/MaxRounds
onready var WonText = $CenterMargin/WonText
onready var BottomText = $BottomMargin/BottomText

var is_game_started = false
var initial_won_text: String

func reset():
	BottomText.text = game_begin_text
	WonText.hide()


func _ready():
	MaxRoundsText.text = MaxRoundsText.text % "5"  # TODO max
	initial_won_text = WonText.text
	reset()
	

func _on_Game_ball_rolling():
	if not is_game_started:
		is_game_started = true
		BottomText.hide()


func _on_Game_won(player_name):
	WonText.text = WonText.text % "SomeOne"
	WonText.show()
	BottomText.text = reset_text
	BottomText.show()
