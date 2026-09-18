class_name Player
extends Actor

const MAX_SPEED := 657.0
const ACCELERATION := 1476.563
const RISE_GRAVITY := 1012.5
const JUMP_VELOCITY := -928.125

const MAX_TILT_ANGLE := deg_to_rad(5.0)


func move_horizontal(delta: float) -> float:
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION * delta)
	sprite.rotation = remap(velocity.x, -MAX_SPEED, MAX_SPEED, MAX_TILT_ANGLE, -MAX_TILT_ANGLE)
	return direction
