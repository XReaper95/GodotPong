extends KinematicBody2D

signal paddle_collision
signal wall_collision

export var initial_arc = 40
export var speed = 400

onready var initial_pos = transform
onready var vel = Vector2.ZERO
onready var frozen = true


func get_random_direction():
	var rand_num = rand_range(-1, 1)
	var side = rand_num / abs(rand_num)
	var random_angle

	if side > 0:
		random_angle = rand_range(180 - initial_arc, 180 + initial_arc)
	else:
		random_angle = rand_range(360 + initial_arc, 360 - initial_arc)

	return deg2rad(random_angle)


func reset_pos():
	vel = Vector2.ZERO
	frozen = true
	transform = initial_pos


func _ready():
	randomize()


func _physics_process(delta):
	if not frozen:
		var collision = move_and_collide(vel * delta)
		if collision != null:
			vel = vel.bounce(collision.normal)
			
			# colide and signal for sound effects
			if collision.collider.is_in_group("wall"):
				emit_signal("wall_collision")
			elif collision.collider.is_in_group("paddle"):
				emit_signal("paddle_collision")
	
	
func _on_Game_ball_rolling():
	if frozen:
		var direction =  self.get_random_direction()
		vel.x = speed * cos(direction)
		vel.y = speed * sin(direction)
		frozen = false
