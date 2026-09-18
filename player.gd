class_name Player
extends CharacterBody2D

const MAX_SPEED := 657.0
const ACCELERATION := 1476.563
const RISE_GRAVITY := 1012.5
const FALL_GRAVITY := 5062.5
const MAX_FALL_SPEED := 1164.375
const JUMP_VELOCITY := -928.125

const LAND_SQUASH_DURATION := 1.0
const LAND_SQUASH_SCALE := Vector2(1.3, 0.7)

const AIR_SQUASH_MAX_Y := 1.2
const AIR_SQUASH_MIN_X := 0.9

const MAX_TILT_ANGLE := deg_to_rad(5.0)

@onready var sprite: Sprite2D = $Sprite2D

var _squash_tween: Tween


func play_bounce() -> void:
	cancel_squash()
	_squash_tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	_squash_tween.tween_property(sprite, "scale", Vector2.ONE, LAND_SQUASH_DURATION) \
	.from(LAND_SQUASH_SCALE)


func cancel_squash() -> void:
	if _squash_tween:
		_squash_tween.kill()


func move_horizontal(delta: float) -> float:
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION * delta)
	sprite.rotation = remap(velocity.x, -MAX_SPEED, MAX_SPEED, MAX_TILT_ANGLE, -MAX_TILT_ANGLE)
	return direction
