extends KinematicBody2D

export var _speed := 400

onready var _initial_pos := position
onready var _velocity := Vector2.ZERO
onready var _direction_provider = get_node("DirectionProvicer") as RandomDirectionProvider

func _ready():
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(_velocity * delta)
	if collision != null:
		_velocity = _velocity.bounce(collision.normal)


func launch():
	var direction = _direction_provider.get_random_direction()
	_velocity.x = _speed * cos(direction)
	_velocity.y = _speed * sin(direction)
	set_physics_process(true)


func reset_position():
	set_physics_process(false)
	position = _initial_pos



