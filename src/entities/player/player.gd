extends KinematicBody2D

export var speed = 400
export var id: int
	
func _physics_process(delta):
	var vel = Vector2.ZERO
	if Input.is_action_pressed("up_%s" % id):
		vel.y -= 1
	if Input.is_action_pressed("down_%s" % id):
		vel.y += 1
	
# warning-ignore:return_value_discarded
	move_and_collide(vel * delta * speed)
