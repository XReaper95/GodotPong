extends KinematicBody2D

export var speed = 400
export var id: int

onready var start_pos = position

var frozen = false


func reset():
	position = start_pos
	frozen = false


func _physics_process(delta):
	if not frozen:
		var vel = Vector2.ZERO
		if Input.is_action_pressed("up_%s" % id):
			vel.y -= 1
		if Input.is_action_pressed("down_%s" % id):
			vel.y += 1
	
		# warning-ignore:return_value_discarded
		move_and_collide(vel * delta * speed)


func _on_Game_won(_player_name):
	frozen = true


func _on_Game_reseted():
	reset()
