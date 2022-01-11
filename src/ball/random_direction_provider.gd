extends Node2D
class_name RandomDirectionProvider

export var initial_arc := 40

func get_random_direction() -> float:
	var rand_num: int = rand_range(-1, 1)
	var side = rand_num / abs(rand_num)
	var random_angle

	if side > 0:
		random_angle = rand_range(180 - initial_arc, 180 + initial_arc)
	else:
		random_angle = rand_range(360 + initial_arc, 360 - initial_arc)

	return deg2rad(random_angle)

