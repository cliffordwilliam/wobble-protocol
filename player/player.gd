class_name Player
extends Actor

const MAX_SPEED := 657.0
const ACCELERATION := 1476.563
const RISE_GRAVITY := 1012.5
const JUMP_VELOCITY := -928.125


func move_horizontal(delta: float) -> float:
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION * delta)
	apply_tilt(MAX_SPEED)
	return direction


func move(is_falling: bool = false) -> void:
	move_and_slide()
	_check_enemy_collision(is_falling)


func _check_enemy_collision(is_falling: bool) -> void:
	for i in get_slide_collision_count():
		var collider := get_slide_collision(i).get_collider()
		if collider is Enemy:
			if is_falling:
				collider.squish()
				velocity.y = JUMP_VELOCITY
			else:
				queue_free()
